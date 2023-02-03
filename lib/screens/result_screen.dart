import 'package:app_rareuser/providers/influencer.dart';
import 'package:app_rareuser/widgets/custom_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../service/ad_mob_service.dart';
import '../widgets/influencer-list-tile.dart';

class Resultscreen extends StatefulWidget {
  final String param;
  final String query;
  final String name;
  const Resultscreen({
    required this.param,
    required this.query,
    required this.name,
  });
  static const routeName = '/search';

  @override
  State<Resultscreen> createState() => _ResultscreenState();
}

class _ResultscreenState extends State<Resultscreen> {
  var _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<Influencer>(context, listen: false)
        .search(widget.param, widget.query)
        .catchError((error) {})
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final influData = Provider.of<Influencer>(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Row(
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              : influData.items_search.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Not any user found.',
                            style: TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Colors.black),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: influData.items_search.length,
                      itemBuilder: ((_, i) {
                        if (i % 3 == 0 && i > 0) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: CustomBannerAds(),
                          );
                        } else {
                          return InfluencerListTile(
                            influData.items_search[i].sId.toString(),
                            influData.items_search[i].name.toString(),
                            influData.items_search[i].pic.toString(),
                            influData.items_search[i].desc.toString(),
                            influData.items_search[i].country!.countryId
                                .toString(),
                            influData.items_search[i].country!.name.toString(),
                            influData.items_search[i].gender.toString(),
                            influData.items_search[i].tags!.toList(),
                          );
                        }
                      }),
                    ),
        ));
  }
}
