import 'dart:convert';

import 'package:app_rareuser/screens/pic_screen.dart';
import 'package:app_rareuser/screens/post_screen.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/influencer_model.dart';
import '../providers/influencer.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});
  static const routeName = '/detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var _isLoading = false;
  String _name = '';

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      Provider.of<Influencer>(context, listen: false)
          .detail(args)
          .catchError((error) {})
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
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
      });
    } else {
      setState(() {
        _name = influData.items_detail[0].name.toString();
      });
    }
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          _name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/run.png",
                  width: 400.0,
                  fit: BoxFit.contain,
                ),
                CircularProgressIndicator(),
              ],
            )
          : influData.items_detail.length == 0
              ? Center(
                  child: Text('Not Found'),
                )
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(influData
                                        .items_detail[0].pic
                                        .toString()),
                                    maxRadius: 50,
                                    minRadius: 15,
                                  ),
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
                                  Container(
                                    width: double.infinity,
                                    height: 26,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: influData
                                            .items_detail[0].platforms?.length,
                                        itemBuilder: ((context, index) => Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    _launchURL(influData
                                                        .items_detail[0]
                                                        .platforms![index]
                                                        .link
                                                        .toString());
                                                  },
                                                  child: Text(
                                                    influData
                                                        .items_detail[0]
                                                        .platforms![index]
                                                        .platform
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              StadiumBorder()),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    influData.items_detail[0].desc.toString(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 5),
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
                                            height: 15,
                                            width: 15),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          influData
                                              .items_detail[0].country!.name
                                              .toString(),
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 26,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: influData
                                            .items_detail[0].tags?.length,
                                        itemBuilder: ((context, index) => Row(
                                              children: [
                                                ElevatedButton(
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
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          shape:
                                                              StadiumBorder()),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
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
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  influData.items_detail[0]
                                                      .posts![j].thumbnail
                                                      .toString(),
                                                  height: 250,
                                                  fit: BoxFit.fill,
                                                ),
                                              ],
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
