import Flutter
import UIKit
import google_mobile_ads

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    registerNativeAds()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    private func registerNativeAds() {
        
        let smallAdFactory = NativeSmallAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "smallNativeAds", nativeAdFactory: smallAdFactory)
        
        let mediumAdFactory = NativeMediumAdFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "mediumNativeAds", nativeAdFactory: mediumAdFactory)
        
        let fullScreenAdSquareFactory = NativeFullScreenAdSquareFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "fullscreenNativeAdsSquare", nativeAdFactory: fullScreenAdSquareFactory)
        
        let fullScreenAdLandScapeFactory = NativeFullScreenAdLandScapeFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "fullscreenNativeAdsLandScape", nativeAdFactory: fullScreenAdLandScapeFactory)
        
        let fullScreenAdPortraitFactory = NativeFullScreenAdPortraitFactory()
        FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
            self, factoryId: "fullscreenNativeAdsPortrait", nativeAdFactory: fullScreenAdPortraitFactory)
    }
}
