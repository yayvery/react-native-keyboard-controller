package com.reactnativekeyboardcontroller.views

import android.annotation.SuppressLint
import android.util.Log
import androidx.appcompat.widget.FitWindowsLinearLayout
import androidx.core.view.ViewCompat
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsAnimationCompat
import androidx.core.view.WindowInsetsCompat
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.views.view.ReactViewGroup
import com.reactnativekeyboardcontroller.KeyboardAnimationCallback
import com.reactnativekeyboardcontroller.R
import com.reactnativekeyboardcontroller.extensions.removeSelf
import com.reactnativekeyboardcontroller.extensions.requestApplyInsetsWhenAttached

private val TAG = EdgeToEdgeReactViewGroup::class.qualifiedName

@SuppressLint("ViewConstructor")
class EdgeToEdgeReactViewGroup(private val reactContext: ThemedReactContext) : ReactViewGroup(reactContext) {
  private var isStatusBarTranslucent = false
  private var isNavigationBarTranslucent = false
  private var eventView: ReactViewGroup? = null

  // region View lifecycles
  override fun onAttachedToWindow() {
    super.onAttachedToWindow()

    reactContext.currentActivity?.let {
      WindowCompat.setDecorFitsSystemWindows(
        it.window,
        false,
      )
    }

    val activity = reactContext.currentActivity

    if (activity == null) {
      Log.w(TAG, "Can not setup keyboard animation listener, since `currentActivity` is null")
      return
    }

    eventView = ReactViewGroup(context)
    val root = this.getContentView()
    root?.addView(eventView)

    val callback = KeyboardAnimationCallback(
      view = this,
      persistentInsetTypes = WindowInsetsCompat.Type.systemBars(),
      deferredInsetTypes = WindowInsetsCompat.Type.ime(),
      dispatchMode = WindowInsetsAnimationCompat.Callback.DISPATCH_MODE_CONTINUE_ON_SUBTREE,
      context = reactContext,
      onApplyWindowInsetsListener = { _, insets ->
        val content = this.getContentView()
        content?.setPadding(
          0,
          if (this.isStatusBarTranslucent) {
            0
          } else {
            insets?.getInsets(WindowInsetsCompat.Type.systemBars())?.top
              ?: 0
          },
          0,
          if (this.isNavigationBarTranslucent) {
            0
          } else {
            insets?.getInsets(WindowInsetsCompat.Type.navigationBars())?.bottom
              ?: 0
          },
        )

        insets
      },
    )

    eventView?.let {
      ViewCompat.setWindowInsetsAnimationCallback(it, callback)
      ViewCompat.setOnApplyWindowInsetsListener(it, callback)
      it.requestApplyInsetsWhenAttached()
    }
  }

  override fun onDetachedFromWindow() {
    super.onDetachedFromWindow()

    eventView.removeSelf()
  }
  // endregion

  // region Props setters
  fun setStatusBarTranslucent(isStatusBarTranslucent: Boolean) {
    this.isStatusBarTranslucent = isStatusBarTranslucent
  }

  fun setNavigationBarTranslucent(isNavigationBarTranslucent: Boolean) {
    this.isNavigationBarTranslucent = isNavigationBarTranslucent
  }
  // endregion

  private fun getContentView(): FitWindowsLinearLayout? {
    return reactContext.currentActivity?.window?.decorView?.rootView?.findViewById(
      R.id.action_bar_root,
    )
  }
}
