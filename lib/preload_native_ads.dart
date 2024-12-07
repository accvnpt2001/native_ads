// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'normal_native_ads.dart';

class PreloadNativeAdsManager {
  static final PreloadNativeAdsManager _instance = PreloadNativeAdsManager._internal();

  // Private constructor
  PreloadNativeAdsManager._internal();

  // Factory constructor to return the singleton instance
  factory PreloadNativeAdsManager() {
    return _instance;
  }

  static final Map<String, PreloadNativeAdsModel> nativeAds = {};

  static void preloadNativeAds(
      {required String name,
      required String adUnitId,
      required TemplateAdType templateType,
      Function(Ad)? onAdClicked,
      Function(Ad)? onAdOpened,
      Function(Ad, double, PrecisionType, String)? onPaidEvent}) {
    NativeAd(
      adUnitId: adUnitId,
      factoryId: switch (templateType) {
        TemplateAdType.small => 'smallNativeAds',
        TemplateAdType.medium => 'mediumNativeAds',
        TemplateAdType.fullscreenSquare => 'fullscreenNativeAdsSquare',
        TemplateAdType.fullscreenLandScape => 'fullscreenNativeAdsLandScape',
        TemplateAdType.fullscreenPortrait => 'fullscreenNativeAdsPortrait',
      },
      request: const AdRequest(),
      // nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          nativeAds[name] = PreloadNativeAdsModel(type: templateType, ad: ad as NativeAd, name: name);
        },
        onAdFailedToLoad: (ad, error) {
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
        onAdClicked: onAdClicked,
        onAdOpened: onAdOpened,
        onPaidEvent: onPaidEvent,
      ),
    ).load();
  }
}

class PreloadNativeAdsModel {
  final TemplateAdType type;
  final NativeAd ad;
  final String name;

  PreloadNativeAdsModel({
    required this.type,
    required this.ad,
    required this.name,
  });
}

class PreloadNativeAds extends StatefulWidget {
  final String name;
  final BoxDecoration? decoration;
  final Widget? loadingWidget;
  final EdgeInsetsGeometry? padding;
  final double? height;

  const PreloadNativeAds({
    super.key,
    required this.name,
    this.decoration,
    this.loadingWidget,
    this.padding,
    this.height,
  });

  @override
  State<PreloadNativeAds> createState() => _PreloadNativeAdsState();
}

class _PreloadNativeAdsState extends State<PreloadNativeAds> {
  PreloadNativeAdsModel? data;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    data = PreloadNativeAdsManager.nativeAds[widget.name];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reloadState();
    });
  }

  void _reloadState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      data = PreloadNativeAdsManager.nativeAds[widget.name];
      if (data != null) {
        timer.cancel();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding,
        decoration: widget.decoration,
        child: data != null
            ? FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 60, // minimum recommended width
                      minHeight: 0, // minimum recommended height
                      maxWidth: MediaQuery.sizeOf(context).width,
                      maxHeight: widget.height ??
                          switch (data!.type) {
                                TemplateAdType.medium => 266,
                                TemplateAdType.fullscreenSquare => MediaQuery.sizeOf(context).height,
                                TemplateAdType.fullscreenLandScape => MediaQuery.sizeOf(context).height,
                                TemplateAdType.fullscreenPortrait => MediaQuery.sizeOf(context).height,
                                TemplateAdType.small => 120,
                              } -
                              (widget.padding?.vertical ?? 0),
                    ),
                    child: AdWidget(ad: data!.ad)),
              )
            : widget.loadingWidget ?? Container(width: 200, height: 200, color: Colors.red));
  }
}
