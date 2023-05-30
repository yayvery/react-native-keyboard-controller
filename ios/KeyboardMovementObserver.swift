//
//  KeyboardMovementObserver.swift
//  KeyboardController
//
//  Created by Kiryl Ziusko on 2.08.22.
//  Copyright © 2022 Facebook. All rights reserved.
//

import Foundation

func interpolate(inputRange: [CGFloat], outputRange: [CGFloat], currentValue: CGFloat) -> CGFloat {
  let inputMin = inputRange.min() ?? 0
  let inputMax = inputRange.max() ?? 1
  let outputMin = outputRange.min() ?? 0
  let outputMax = outputRange.max() ?? 1

  let normalizedValue = (currentValue - inputMin) / (inputMax - inputMin)
  let interpolatedValue = outputMin + (outputMax - outputMin) * normalizedValue

  return interpolatedValue
}

class ProgressView: UIView {
    override class var layerClass: AnyClass {
        return CAProgressLayer.self
    }
}

@objc(KeyboardMovementObserver)
public class KeyboardMovementObserver: NSObject, CAProgressLayerDelegate {
  // class members
  var onEvent: (NSString, NSNumber, NSNumber) -> Void
  var onNotify: (String, Any) -> Void
  // progress tracker
  private var _keyboardView: UIView?
  private var keyboardView: UIView? {
    let windowsCount = UIApplication.shared.windows.count

    if _keyboardView == nil || windowsCount != _windowsCount {
      _keyboardView = findKeyboardView()
      _windowsCount = windowsCount
    }

    return _keyboardView
  }

  private var _windowsCount: Int = 0
  private var prevKeyboardPosition = 0.0
  private var displayLink: CADisplayLink?
  private var keyboardHeight: CGFloat = 0.0
  private var hasKVObserver = false
    
    private var view: UIView?

  @objc public init(
    handler: @escaping (NSString, NSNumber, NSNumber) -> Void,
    onNotify: @escaping (String, Any) -> Void,
    view: UIView
  ) {
    onEvent = handler
    self.onNotify = onNotify
      self.view = view
  }
    
    func progressDidChange(to progress: CGFloat) {
        onEvent("onKeyboardMoveStart", keyboardHeight * progress as NSNumber, progress as NSNumber)
    }

  @objc public func mount() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillDisappear),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillAppear),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardDidAppear),
      name: UIResponder.keyboardDidShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardDidDisappear),
      name: UIResponder.keyboardDidHideNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(windowDidBecomeVisible),
      name: UIWindow.didBecomeVisibleNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(windowDidBecomeHidden),
      name: UIWindow.didBecomeHiddenNotification,
      object: nil
    )
     
      ///////////////////////////////////////////////
  }

  @objc func windowDidBecomeHidden(_: Notification) {
    removeKVObserver()
  }

  @objc func windowDidBecomeVisible(_: Notification) {
    setupKVObserver()
  }

  private func setupKVObserver() {
    if hasKVObserver {
      return
    }

    if keyboardView != nil {
      hasKVObserver = true
      keyboardView?.addObserver(self, forKeyPath: "center", options: .new, context: nil)
    }
  }

  private func removeKVObserver() {
    if !hasKVObserver {
      return
    }

    hasKVObserver = false
    _keyboardView?.removeObserver(self, forKeyPath: "center", context: nil)
  }

  // swiftlint:disable:next block_based_kvo
  @objc override public func observeValue(
    forKeyPath keyPath: String?,
    of object: Any?,
    change: [NSKeyValueChangeKey: Any]?,
    context _: UnsafeMutableRawPointer?
  ) {
    // swiftlint:disable:next force_cast
    if keyPath == "center", object as! NSObject == _keyboardView! {
      // if we are currently animating keyboard or keyboard is not shown yet -> we need to ignore values from KVO
      if displayLink != nil || keyboardHeight == 0.0 {
        return
      }

      // swiftlint:disable:next force_cast
      let keyboardFrameY = (change?[.newKey] as! NSValue).cgPointValue.y
      let keyboardWindowH = keyboardView?.window?.bounds.size.height ?? 0
      let keyboardPosition = keyboardWindowH - keyboardFrameY
      let position = interpolate(
        inputRange: [keyboardHeight / 2, -keyboardHeight / 2],
        outputRange: [keyboardHeight, 0],
        currentValue: keyboardPosition
      )

      if position == 0 {
        // it will be triggered before `keyboardWillDisappear` and
        // we don't need to trigger `onInteractive` handler for that
        // since it will be handled in `keyboardWillDisappear` function
        return
      }

      onEvent("onKeyboardMoveInteractive", position as NSNumber, position / CGFloat(keyboardHeight) as NSNumber)
    }
  }

  @objc public func unmount() {
    // swiftlint:disable:next notification_center_detachment
    NotificationCenter.default.removeObserver(self)
  }

  @objc func keyboardWillAppear(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      self.keyboardHeight = keyboardHeight

      var data = [AnyHashable: Any]()
      data["height"] = keyboardHeight

      onEvent("onKeyboardMoveStart", Float(keyboardHeight) as NSNumber, 1)
      onNotify("KeyboardController::keyboardWillShow", data)

    /*UIView.animate(withDuration: 0.1, animations: { () -> Void in
        self.view?.frame.origin.y -= keyboardHeight
            })*/
        
        var animations = [CAAnimation]()
        
        let progressAnimation = CASpringAnimation(keyPath: "progress")
                        progressAnimation.fromValue = 0
                        progressAnimation.toValue = 1
                        progressAnimation.duration = 0.5
                        progressAnimation.damping = 500
                        progressAnimation.stiffness = 1000
                        progressAnimation.mass = 3
                        animations.append(progressAnimation)
        
        let newSublayer = CALayer()
        let screenSize: CGRect = UIScreen.main.bounds
                    let size = 50.0
        newSublayer.frame = CGRect(x: 20, y: screenSize.height - size, width: size, height: size)
        newSublayer.cornerRadius = size / 2
        newSublayer.backgroundColor = UIColor.green.cgColor
        self.view?.layer.addSublayer(newSublayer)
        let progressView = ProgressView(frame: newSublayer.frame)
                        progressView.layer.delegate = self
        self.view?.addSubview(progressView)
        
        CATransaction.begin()
                progressView.layer.add(progressAnimation, forKey: nil)
                CATransaction.commit()
        
      setupKeyboardWatcher()
    }
  }

  @objc func keyboardWillDisappear() {
    var data = [AnyHashable: Any]()
    data["height"] = 0

    onEvent("onKeyboardMoveStart", 0, 0)
    onNotify("KeyboardController::keyboardWillHide", data)

      UIView.animate(withDuration: 0.1, animations: { () -> Void in
          self.view?.frame.origin.y += self.keyboardHeight
      })
      
    setupKeyboardWatcher()
  }

  @objc func keyboardDidAppear(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      self.keyboardHeight = keyboardHeight

      var data = [AnyHashable: Any]()
      data["height"] = keyboardHeight

      onEvent("onKeyboardMoveEnd", keyboardHeight as NSNumber, 1)
      onNotify("KeyboardController::keyboardDidShow", data)

      removeKeyboardWatcher()
    }
  }

  @objc func keyboardDidDisappear() {
    var data = [AnyHashable: Any]()
    data["height"] = 0

    keyboardHeight = 0.0

    onEvent("onKeyboardMoveEnd", 0 as NSNumber, 0)
    onNotify("KeyboardController::keyboardDidHide", data)

    removeKeyboardWatcher()
  }

  @objc func setupKeyboardWatcher() {
    // sometimes `will` events can be called multiple times.
    // To avoid double re-creation of listener we are adding this condition
    // (if active link is present, then no need to re-setup a listener)
    if displayLink != nil {
      return
    }

    displayLink = CADisplayLink(target: self, selector: #selector(updateKeyboardFrame))
    displayLink?.preferredFramesPerSecond = 120 // will fallback to 60 fps for devices without Pro Motion display
    displayLink?.add(to: .main, forMode: .common)
  }

  @objc func removeKeyboardWatcher() {
    displayLink?.invalidate()
    displayLink = nil
  }

  // https://stackoverflow.com/questions/32598490/show-uiview-with-buttons-over-keyboard-like-in-skype-viber-messengers-swift-i
  func findKeyboardView() -> UIView? {
    var result: UIView?

    let windows = UIApplication.shared.windows
    for window in windows {
      if window.description.hasPrefix("<UITextEffectsWindow") {
        for subview in window.subviews {
          if subview.description.hasPrefix("<UIInputSetContainerView") {
            for hostView in subview.subviews {
              if hostView.description.hasPrefix("<UIInputSetHostView") {
                result = hostView as? UIView
                break
              }
            }
            break
          }
        }
        break
      }
    }
    return result
  }

  @objc func updateKeyboardFrame() {
    if keyboardView == nil {
      return
    }

    let keyboardFrameY = keyboardView?.layer.presentation()?.frame.origin.y ?? 0
    let keyboardWindowH = keyboardView?.window?.bounds.size.height ?? 0
    let keyboardPosition = keyboardWindowH - keyboardFrameY

    if keyboardPosition == prevKeyboardPosition || keyboardFrameY == 0 {
      return
    }

    prevKeyboardPosition = keyboardPosition
    onEvent("onKeyboardMove", keyboardPosition as NSNumber, keyboardPosition / CGFloat(keyboardHeight) as NSNumber)
  }
}