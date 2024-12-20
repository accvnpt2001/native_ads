//
//  NativeAdFactory.swift
//  Runner
//

import google_mobile_ads
import Flutter

var adsChannel : FlutterMethodChannel = FlutterMethodChannel()
var buttonBkg : String = "#ed6f65"
var buttonTextColor : String = "#ffffff"
var headlineTextColor = "#000000"
var bodyTextColor = "#5b5b5b"

class NativeSmallAdFactory : FLTNativeAdFactory {
    
    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("SmallAds", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView
        
        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline

        (nativeAdView.bodyView as! UILabel).text =  nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        
        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil
        adsChannel.invokeMethod("PassAdsData", arguments: "\((nativeAdView.headlineView as! UILabel).text)")

        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction?.uppercased(), for: .normal)
        (nativeAdView.callToActionView as? UIButton)?.titleLabel?.adjustsFontSizeToFitWidth = true
        (nativeAdView.callToActionView as? UIButton)?.titleLabel?.minimumScaleFactor = 0.5
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        
        // set Color
        nativeAdView.callToActionView?.backgroundColor = UIColor(hex: buttonBkg)
        (nativeAdView.callToActionView as? UIButton)?.setTitleColor(UIColor(hex: buttonTextColor), for: .normal)
        (nativeAdView.headlineView as! UILabel).textColor = UIColor(hex: headlineTextColor)
        (nativeAdView.bodyView as! UILabel).textColor = UIColor(hex: bodyTextColor)

        nativeAdView.nativeAd = nativeAd
        
        return nativeAdView
    }
}

class NativeMediumAdFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("MediumAds", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView
//
        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        adsChannel.invokeMethod("PassAdsData", arguments: "\((nativeAdView.headlineView as! UILabel).text)")

        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        
        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        (nativeAdView.iconView as! UIImageView).layer.cornerRadius = 6
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil

        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction?.uppercased(), for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        

        nativeAdView.nativeAd = nativeAd
        
        // set Color
        nativeAdView.callToActionView?.backgroundColor = UIColor(hex: buttonBkg)
        (nativeAdView.callToActionView as? UIButton)?.setTitleColor(UIColor(hex: buttonTextColor), for: .normal)
        (nativeAdView.headlineView as! UILabel).textColor = UIColor(hex: headlineTextColor)
        (nativeAdView.bodyView as! UILabel).textColor = UIColor(hex: bodyTextColor)
        
        return nativeAdView
    }
}

class NativeFullScreenAdSquareFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("FullScreenAdSquare", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView
        adsChannel.invokeMethod("PassAdsData", arguments: "\((nativeAdView.headlineView as! UILabel).text)")
        //Headline
        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline
        
        
        //Body
        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        
        //Image
        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        (nativeAdView.iconView as! UIImageView).layer.cornerRadius = 6
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil
        
        //CTA
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction?.uppercased(), for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        
        //Media
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
            let heightConstraint = NSLayoutConstraint(
              item: mediaView,
              attribute: .height,
              relatedBy: .equal,
              toItem: mediaView,
              attribute: .width,
              multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
              constant: 0)
            heightConstraint.isActive = true
          }
        if nativeAd.mediaContent.hasVideoContent == false {
            nativeAdView.mediaView?.contentMode = .scaleAspectFill
            nativeAdView.mediaView?.clipsToBounds = true
        }
        // set Color
        nativeAdView.callToActionView?.backgroundColor = UIColor(hex: buttonBkg)
        (nativeAdView.callToActionView as? UIButton)?.setTitleColor(UIColor(hex: buttonTextColor), for: .normal)
        (nativeAdView.headlineView as! UILabel).textColor = UIColor(hex: headlineTextColor)
        (nativeAdView.bodyView as! UILabel).textColor = UIColor(hex: bodyTextColor)
        
        nativeAdView.nativeAd = nativeAd
        
        return nativeAdView
    }
}


class NativeFullScreenAdLandScapeFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("FullScreenAdLandScape", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView
        
        //Headline
        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline
        adsChannel.invokeMethod("PassAdsData", arguments: "\((nativeAdView.headlineView as! UILabel).text)")
        
        //Body
        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        
        //Image
        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        (nativeAdView.iconView as! UIImageView).layer.cornerRadius = 6
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil
        
        //CTA
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction?.uppercased(), for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        
        //Media
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
            let heightConstraint = NSLayoutConstraint(
              item: mediaView,
              attribute: .height,
              relatedBy: .equal,
              toItem: mediaView,
              attribute: .width,
              multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
              constant: 0)
            heightConstraint.isActive = true
          }
        if nativeAd.mediaContent.hasVideoContent == false {
            nativeAdView.mediaView?.contentMode = .scaleAspectFill
            nativeAdView.mediaView?.clipsToBounds = true
        }
        
        // set Color
        nativeAdView.callToActionView?.backgroundColor = UIColor(hex: buttonBkg)
        (nativeAdView.callToActionView as? UIButton)?.setTitleColor(UIColor(hex: buttonTextColor), for: .normal)
        (nativeAdView.headlineView as! UILabel).textColor = UIColor(hex: headlineTextColor)
        (nativeAdView.bodyView as! UILabel).textColor = UIColor(hex: bodyTextColor)
        
        nativeAdView.nativeAd = nativeAd
        
        return nativeAdView
    }
}


class NativeFullScreenAdPortraitFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("FullScreenAdPortrait", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView
        
        //Headline
        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline
        adsChannel.invokeMethod("PassAdsData", arguments: "\((nativeAdView.headlineView as! UILabel).text)")
        //Body
        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil
        
        //Image
        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        (nativeAdView.iconView as! UIImageView).layer.cornerRadius = 6
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil
        
        //CTA
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction?.uppercased(), for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        
        //Media
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
            let heightConstraint = NSLayoutConstraint(
              item: mediaView,
              attribute: .height,
              relatedBy: .equal,
              toItem: mediaView,
              attribute: .width,
              multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
              constant: 0)
            heightConstraint.isActive = true
          }
        if nativeAd.mediaContent.hasVideoContent == false {
            nativeAdView.mediaView?.contentMode = .scaleAspectFit
//            nativeAdView.mediaView?.clipsToBounds = true
        }
        if nativeAdView.mediaView != nil {
            nativeAdView.sendSubviewToBack(nativeAdView.mediaView!)
        }
        
        // set Color
        nativeAdView.callToActionView?.backgroundColor = UIColor(hex: buttonBkg)
        (nativeAdView.callToActionView as? UIButton)?.setTitleColor(UIColor(hex: buttonTextColor), for: .normal)
        (nativeAdView.headlineView as! UILabel).textColor = UIColor(hex: headlineTextColor)
        (nativeAdView.bodyView as! UILabel).textColor = UIColor(hex: bodyTextColor)
        
        nativeAdView.nativeAd = nativeAd
        
        return nativeAdView
    }
}
