import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    return 'ca-app-pub-3940256099942544/6300978111'; //Test
    // return 'ca-app-pub-7552873818056721/5227029496';
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
