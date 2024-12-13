import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum TemplateAdType { small, medium, fullscreenSquare, fullscreenLandScape, fullscreenPortrait }

class NormalAdsNative extends StatefulWidget {
  final TemplateAdType templateType;
  final String adUnitId;
  final Color? color;
  final Widget? loadingWidget;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final void Function(String)? onGetTitle;
  final void Function(Ad)? onAdClicked;
  final void Function(Ad)? onAdOpened;
  final void Function(Ad, double, PrecisionType, String)? onPaidEvent;

  const NormalAdsNative({
    super.key,
    required this.templateType,
    required this.adUnitId,
    this.color,
    this.loadingWidget,
    this.padding,
    this.height,
    this.onAdClicked,
    this.onAdOpened,
    this.onPaidEvent,
    this.onGetTitle,
  });

  @override
  State<NormalAdsNative> createState() => _NormalAdsNativeState();
}

class _NormalAdsNativeState extends State<NormalAdsNative> with AutomaticKeepAliveClientMixin {
  late NativeAd _nativeAd;
  bool isNativeAdReady = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    const MethodChannel channel = MethodChannel('AdsChannel');
    channel.setMethodCallHandler((call) async {
      if (call.method == "PassAdsData") {
        final title = call.arguments as String;
        widget.onGetTitle?.call(title);
      }
      return;
    });
    _nativeAd = NativeAd(
      adUnitId: widget.adUnitId,
      factoryId: _getFactoryId(widget.templateType), // Use a helper method to get factoryId
      request: const AdRequest(),
      // nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium),
      listener: NativeAdListener(
        onAdLoaded: (ad) async {
          _nativeAd = ad as NativeAd;
          isNativeAdReady = true;
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 500));
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose(); // Dispose of the ad if it fails to load
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
        onAdClicked: widget.onAdClicked,
        onAdOpened: widget.onAdOpened,
        onPaidEvent: widget.onPaidEvent,
      ),
    )..load(); // Ensure load is called on the NativeAd instance
  }

  String _getFactoryId(TemplateAdType type) {
    switch (type) {
      case TemplateAdType.small:
        return 'smallNativeAds';
      case TemplateAdType.medium:
        return 'mediumNativeAds';
      case TemplateAdType.fullscreenSquare:
        return 'fullscreenNativeAdsSquare';
      case TemplateAdType.fullscreenLandScape:
        return 'fullscreenNativeAdsLandScape';
      case TemplateAdType.fullscreenPortrait:
        return 'fullscreenNativeAdsPortrait';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final mediaQuery = MediaQuery.of(context); // Correct usage of MediaQuery
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color,
      ),
      child: isNativeAdReady
          ? FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 60,
                    minHeight: 0,
                    maxWidth: mediaQuery.size.width,
                    maxHeight: widget.height ?? _getAdHeight(mediaQuery),
                  ),
                  child: AdWidget(ad: _nativeAd)),
            )
          : widget.loadingWidget ??
              Container(
                height: widget.height ?? _getAdHeight(mediaQuery),
                width: mediaQuery.size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey),
                child: const Center(
                  child: Text(
                    "Ad loading...",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
    );
  }

  double _getAdHeight(MediaQueryData mediaQuery) {
    switch (widget.templateType) {
      case TemplateAdType.medium:
        return 270;
      case TemplateAdType.fullscreenSquare:
      case TemplateAdType.fullscreenLandScape:
      case TemplateAdType.fullscreenPortrait:
        return mediaQuery.size.height;
      case TemplateAdType.small:
        return 120;
    }
  }
}
