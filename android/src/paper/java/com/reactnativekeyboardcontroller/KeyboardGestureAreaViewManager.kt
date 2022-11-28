package com.reactnativekeyboardcontroller

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.views.view.ReactViewManager
import com.reactnativekeyboardcontroller.managers.KeyboardGestureAreaViewManagerImpl
import com.reactnativekeyboardcontroller.views.KeyboardGestureAreaReactViewGroup

class KeyboardGestureAreaViewManager(mReactContext: ReactApplicationContext) : ReactViewManager() {
  private val manager = KeyboardGestureAreaViewManagerImpl(mReactContext)

  override fun getName(): String = KeyboardGestureAreaViewManagerImpl.NAME

  override fun createViewInstance(reactContext: ThemedReactContext): KeyboardGestureAreaReactViewGroup {
    return manager.createViewInstance(reactContext)
  }

  @ReactProp(name = "interpolator")
  fun setInterpolator(view: KeyboardGestureAreaReactViewGroup, interpolator: String) {
    view.setInterpolator(interpolator)
  }
}
