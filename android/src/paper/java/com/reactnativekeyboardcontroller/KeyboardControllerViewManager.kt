package com.reactnativekeyboardcontroller

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.views.view.ReactViewManager
import com.reactnativekeyboardcontroller.managers.KeyboardControllerViewManagerImpl
import com.reactnativekeyboardcontroller.views.EdgeToEdgeReactViewGroup

class KeyboardControllerViewManager(mReactContext: ReactApplicationContext) : ReactViewManager() {
  private val manager = KeyboardControllerViewManagerImpl(mReactContext)

  override fun getName(): String = KeyboardControllerViewManagerImpl.NAME

  override fun createViewInstance(reactContext: ThemedReactContext): EdgeToEdgeReactViewGroup {
    return manager.createViewInstance(reactContext)
  }

  @ReactProp(name = "enabled")
  fun setEnabled(view: EdgeToEdgeReactViewGroup, enabled: Boolean) {
    manager.setEnabled(view, enabled)
  }

  override fun getExportedCustomDirectEventTypeConstants(): MutableMap<String, Any> {
    return manager.getExportedCustomDirectEventTypeConstants()
  }
}
