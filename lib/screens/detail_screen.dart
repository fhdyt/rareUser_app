import 'dart:convert';

import 'package:app_rareuser/screens/pic_screen.dart';
import 'package:app_rareuser/screens/post_screen.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:app_rareuser/widgets/custom_banner_ads.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/influencer.dart';

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

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Influencer>(context, listen: false)
        .detail(widget.args)
        .catchError((error) {})
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final args = ModalRoute.of(context)!.settings.arguments as String;

    // });
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
    final influData = Provider.of<Influencer>(context);
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
    // final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xfff7f7f7), //change your color here
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _name,
                style: TextStyle(
                    color: Color(0xfff7f7f7), fontWeight: FontWeight.bold),
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
        ),
        backgroundColor: Color(0xff1A1A1A),
        elevation: 0,
      ),
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
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        influData.items_detail[0].pic
                                            .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //   backgroundImage: NetworkImage(influData
                                  //       .items_detail[0].pic
                                  //       .toString()),
                                  //   maxRadius: 40,
                                  //   minRadius: 15,
                                  // ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PicScreen(
                                            url: influData.items_detail[0].pic
                                                .toString()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
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
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flag.fromString(
                                            influData.items_detail[0].country!
                                                .countryId
                                                .toString(),
                                            height: 20,
                                            width: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          influData
                                              .items_detail[0].country!.name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Color(0xfff7f7f7),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 30,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: influData
                                          .items_detail[0].tags?.length,
                                      itemBuilder: ((context, index) => Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => Resultscreen(
                                                            param: 'tags',
                                                            query: influData
                                                                .items_detail[0]
                                                                .tags![index],
                                                            name: influData
                                                                .items_detail[0]
                                                                .tags![index]),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    '#${influData.items_detail[0].tags?[index]}',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0xff1a1a1a)),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                    backgroundColor:
                                                        Color(0xff93deff),
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
                          child: CustomBannerAds(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
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
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
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
                                itemCount:
                                    influData.items_detail[0].platforms?.length,
                                itemBuilder: ((context, index) => Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            _launchURL(influData.items_detail[0]
                                                .platforms![index].link
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
                                    'Please note that the following post has been extracted from the ${_name} account.',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    influData.items_detail[0].posts?.length,
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
                                                builder: (context) =>
                                                    PostScreen(
                                                        url: influData
                                                            .items_detail[0]
                                                            .posts![j]
                                                            .file
                                                            .toString()),
                                              ),
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: Image.network(
                                              influData.items_detail[0]
                                                  .posts![j].thumbnail
                                                  .toString(),
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
                      ],
                    ),
                  ),
                ),
    );
  }
}
