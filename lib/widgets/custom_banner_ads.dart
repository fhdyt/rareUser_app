import 'package:app_rareuser/service/ad_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAds extends StatefulWidget {
  @override
  State<CustomBannerAds> createState() => _CustomBannerAdsState();
}

class _CustomBannerAdsState extends State<CustomBannerAds> {
  bool _isAdLoaded = false;
  BannerAd? _banner;
  @override
  void initState() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load $error');
        },
        onAdOpened: (ad) => print('Ad Open'),
        onAdClosed: (ad) => print('Ad Close'),
      ),
      request: const AdRequest(),
    );
    _banner!.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: _banner!.size.height.toDouble(),
                child: AdWidget(ad: _banner!),
              ),
            ],
          )
        : SizedBox();
  }
}
