package com.codelab.flutter.admobinlineads

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {

     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
         super.configureFlutterEngine(flutterEngine)
         GoogleMobileAdsPlugin.registerNativeAdFactory(
             flutterEngine,
             "mediumNativeAds",
             NativeAdsFactoryMedium(context)
         )

         GoogleMobileAdsPlugin.registerNativeAdFactory(
             flutterEngine,
             "smallNativeAds",
             NativeAdsFactorySmall(context)
         )

         GoogleMobileAdsPlugin.registerNativeAdFactory(
             flutterEngine,
             "fullscreenNativeAdsSquare",
             NativeAdsFactoryFullSquare(context)
         )

         GoogleMobileAdsPlugin.registerNativeAdFactory(
             flutterEngine,
             "fullscreenNativeAdsLandScape",
             NativeAdsFactoryFullLandScape(context)
         )

         GoogleMobileAdsPlugin.registerNativeAdFactory(
             flutterEngine,
             "fullscreenNativeAdsPortrait",
             NativeAdsFactoryFullPortrait(context)
         )
     }
 }
