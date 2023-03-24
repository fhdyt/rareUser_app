import 'package:app_rareuser/screens/botton_bar_navigation.dart';
import 'package:app_rareuser/service/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestAppBar extends StatefulWidget {
  const TestAppBar({super.key});

  @override
  State<TestAppBar> createState() => _TestAppBarState();
}

class _TestAppBarState extends State<TestAppBar> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var _welcome = false;

  Future<void> _okeWelcom() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('welcome', true).then((bool success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottonBarNavigation()),
      );
    });
  }

  NativeAd? _ad;
  bool isAdLoaded = false;
  @override
  void initState() {
    print("*************** INIT STATE ***************");
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
          print("**** AD ***** ${_add.responseInfo}");
          setState(() {
            _ad = _add;
            isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Test'),
            ElevatedButton(onPressed: _okeWelcom, child: Text('Oke')),
            _ad != null && isAdLoaded
                ? Container(
                    height: 55.0,
                    alignment: Alignment.center,
                    child: AdWidget(ad: _ad!),
                  )
                : Container(
                    height: 55,
                  )
          ],
        ),
      ),
    );
  }
}
