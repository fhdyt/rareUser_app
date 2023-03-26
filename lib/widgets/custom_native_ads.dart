import 'package:app_rareuser/service/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomNativeAds extends StatefulWidget {
  const CustomNativeAds({super.key});

  @override
  State<CustomNativeAds> createState() => _CustomNativeAdsState();
}

class _CustomNativeAdsState extends State<CustomNativeAds> {
  NativeAd? _ad;
  bool isAdLoaded = false;
  @override
  void initState() {
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var _add = ad as NativeAd;
          setState(() {
            _ad = _add;
            isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => print('Ad clicked.'),
      ),
    );

    _ad!.load();
  }

  @override
  Widget build(BuildContext context) {
    return _ad != null && isAdLoaded
        ? Container(
            height: 90,
            alignment: Alignment.center,
            child: AdWidget(ad: _ad!),
          )
        : Container();
  }
}
