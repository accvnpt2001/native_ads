package com.codelab.flutter.admobinlineads

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
         super.configureFlutterEngine(flutterEngine)
         adsChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "AdsChannel")
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
