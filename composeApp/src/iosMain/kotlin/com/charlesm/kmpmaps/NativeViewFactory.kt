package com.charlesm.kmpmaps

import platform.UIKit.UIViewController

interface NativeViewFactory {
    fun createMapView(
        latitude: Double,
        longitude: Double
    ): UIViewController

}