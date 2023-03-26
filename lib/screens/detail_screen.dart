import 'package:app_rareuser/screens/post_screen.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/influencer.dart';
import '../providers/influencer_detail.dart';
import '../service/ad_helper.dart';
import '../widgets/custom_native_ads.dart';
import '../widgets/incluencer-list-horizontal.dart';

class DetailScreen extends StatefulWidget {
  final String args;
  const DetailScreen({required this.args, super.key});
  static const routeName = '/detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var _isLoading = false;
  String _name = '';
  String _gender = '';
  InterstitialAd? _interstitialAd;

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        // _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        // _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            setState(() {
              _interstitialAd = ad;
            });

            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _interstitialAd = null;
          },
        ));
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _createInterstitialAd();
    setState(() {
      _isLoading = true;
    });

    Provider.of<InfluencerDetail>(context, listen: false)
        .detail(widget.args)
        .catchError((error) {})
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    Provider.of<Influencer>(context, listen: false)
        .related(widget.args)
        .catchError((error) {})
        .then((value) {});
    super.initState();
  }

  Future<void> _launchURL(String _url) async {
    final Uri url_uri = Uri.parse(_url);
    if (!await launchUrl(
      url_uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url_uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final influData = Provider.of<InfluencerDetail>(context);
    final influDataRelated = Provider.of<Influencer>(context);

    if (influData.items_detail.length == 0) {
      setState(() {
        _name = '';
        _gender = '';
      });
    } else {
      setState(() {
        _name = influData.items_detail[0].name.toString();
        _gender = influData.items_detail[0].gender.toString();
      });
    }

    if (influData.detailShow == 5) {
      _showInterstitialAd();
    }

    return Scaffold(
        backgroundColor: Color(0xff1A1A1A),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xfff7f7f7),
                ),
              )
            : influData.items_detail.length == 0
                ? Center(
                    child: Text('Not Found'),
                  )
                : NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.55,
                          floating: true,
                          pinned: true,
                          backgroundColor: Color(0xff1A1A1A),
                          elevation: 0,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      _name,
                                      style: TextStyle(
                                          color: Color(0xfff7f7f7),
                                          fontWeight: FontWeight.bold),
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                                _gender == 'male'
                                    ? Icon(
                                        Icons.male_rounded,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.female_rounded,
                                        color: Colors.pink,
                                      ),
                              ],
                            ),
                            background: Image.network(
                              influData.items_detail[0].pic.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ];
                    },
                    body: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Center(
                        child:
                            contentMethod(influData, influDataRelated, context),
                      ),
                    ),
                  )
        // newMethod(influData, context),
        );
  }

  SingleChildScrollView contentMethod(InfluencerDetail influData,
      Influencer influDataRelated, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          influData.items_detail[0].desc.toString(),
                          style: TextStyle(
                            color: Color(0xfff7f7f7),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flag.fromString(
                                influData.items_detail[0].country!.countryId
                                    .toString(),
                                height: 24,
                                width: 24),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              influData.items_detail[0].country!.name
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xfff7f7f7),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: influData.items_detail[0].tags?.length,
                          itemBuilder: ((context, index) => Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Resultscreen(
                                                param: 'tags',
                                                query: influData.items_detail[0]
                                                    .tags![index],
                                                name: influData.items_detail[0]
                                                    .tags![index]),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        '#${influData.items_detail[0].tags?[index]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff1a1a1a)),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        backgroundColor: Color(0xff93deff),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: CustomNativeAds(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Social Media ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff93deff)),
                      ),
                      Text(
                        'Tap Social Media account below to visit ${_name} profile. ',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: influData.items_detail[0].platforms?.length,
                    itemBuilder: ((context, index) => Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _launchURL(influData
                                    .items_detail[0].platforms![index].link
                                    .toString());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: Color(0xfff7f7f7),
                                      width: 2,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Image.asset(
                                    "assets/images/social_media/${influData.items_detail[0].platforms![index].platform.toString()}.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Divider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posts',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff93deff)),
                      ),
                      Text(
                        'Please note that the following post has been extracted from the ${_name} social media.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: influData.items_detail[0].posts?.length,
                    itemBuilder: ((context, j) => Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, PostScreen.routeName,
                                //     arguments: influData.items_detail[0]
                                //         .posts![j].file
                                //         .toString());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostScreen(
                                        url: influData
                                            .items_detail[0].posts![j].file
                                            .toString()),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: FadeInImage.assetNetwork(
                                  image: influData
                                      .items_detail[0].posts![j].thumbnail
                                      .toString(),
                                  placeholder: "assets/images/loading-post.png",
                                  height: 250,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Related User',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff93deff)),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: influDataRelated.items_related.length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: ((context, i) =>
                              InfluencerListHorizontal(
                                influDataRelated.items_related[i].sId
                                    .toString(),
                                influDataRelated.items_related[i].name
                                    .toString(),
                                influDataRelated.items_related[i].pic
                                    .toString(),
                                influDataRelated.items_related[i].desc
                                    .toString(),
                                influDataRelated
                                    .items_related[i].country!.countryId
                                    .toString(),
                                influDataRelated.items_related[i].country!.name
                                    .toString(),
                                influDataRelated.items_related[i].gender
                                    .toString(),
                                influDataRelated.items_related[i].tags!
                                    .toList(),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
