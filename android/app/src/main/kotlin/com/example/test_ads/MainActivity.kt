package com.codelab.flutter.admobinlineads

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity: FlutterActivity() {
     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
         super.configureFlutterEngine(flutterEngine)
         adsChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "AdsChannel")
         adsChannel!!.setMethodCallHandler { call, result ->
             when (call.method) {
                 "set_color" -> {
                     val arguments = call.arguments as HashMap<String, Any>;
                      buttonBackgroundColor = arguments?.get("button_bkg") as? String ?: "#ed6f65"
                      buttonTextColor = arguments?.get("button_title") as? String ?: "#ffffff"
                      headlineColor = arguments?.get("title") as? String ?: "#000000"
                      bodyColor = arguments?.get("subtitle") as? String ?: "#5b5b5b"
                      adTagBackground = arguments?.get("ad_tag_bkg") as? String ?: "#ed6f65"
                      adTagTextColor = arguments?.get("ad_tag_title") as? String ?: "#ffffff"
                     starColor = arguments?.get("star_color") as? String ?: "#2fd696"

                     result.success(null)
                 }
                 else -> {
                     print("nothing to do on method channel")
                 }
             }
         }
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
