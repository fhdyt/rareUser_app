import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../service/ad_mob_service.dart';

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
      adUnitId: AdMobService.bannerAdUnitId!,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  'Advertisement',
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Container(
                height: _banner!.size.height.toDouble(),
                child: AdWidget(ad: _banner!),
              ),
            ],
          )
        : SizedBox();
  }
}
