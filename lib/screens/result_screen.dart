import 'package:app_rareuser/providers/influencer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

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
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Container(
          child: _isLoading
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
              : influData.items_search.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/sad.png",
                          width: 400.0,
                          fit: BoxFit.contain,
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: influData.items_search.length,
                      itemBuilder: ((_, i) => Column(
                            children: [
                              InfluencerListTile(
                                influData.items_search[i].sId.toString(),
                                influData.items_search[i].name.toString(),
                                influData.items_search[i].pic.toString(),
                                influData.items_search[i].desc.toString(),
                                influData.items_search[i].country!.countryId
                                    .toString(),
                                influData.items_search[i].country!.name
                                    .toString(),
                                influData.items_search[i].gender.toString(),
                                influData.items_search[i].tags!.toList(),
                              ),
                              Divider()
                            ],
                          )),
                    ),
        ));
  }
}
