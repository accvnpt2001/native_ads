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
        let cntrl : FlutterViewController = self.window?.rootViewController as! FlutterViewController
        adsChannel = FlutterMethodChannel(
            name: "AdsChannel",
            binaryMessenger: cntrl.binaryMessenger
        )
        
        adsChannel.setMethodCallHandler {(call: FlutterMethodCall, result: FlutterResult) -> Void in
            switch call.method {
            case "set_color":
                print(call.arguments)
                if let args = call.arguments as? Dictionary<String, Any>,
                   let colorButton = args["button_bkg"] as? String,
                   let colorTextButton = args["button_title"] as? String,
                   let headlineColor = args["title"] as? String,
                   let bodyColor = args["subtitle"] as? String {
                    buttonBkg = colorButton
                    buttonTextColor = colorTextButton
                    headlineTextColor = headlineColor
                    bodyTextColor = bodyColor
                    result(nil)
                } else {
                    result(FlutterError.init(code: "errorSetDebug", message: "data or format error", details: nil))
                }
            default:
                break;
            }
        }
        
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
