import 'package:app_rareuser/service/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    return AdHelper.bannerAdUnitId; //Test
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad Loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      print('Ad failed to load $error');
    },
    onAdOpened: (ad) => print('Ad Open'),
    onAdClosed: (ad) => print('Ad Close'),
  );
}
