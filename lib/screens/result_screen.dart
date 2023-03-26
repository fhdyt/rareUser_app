import 'package:app_rareuser/providers/influencer_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_native_ads.dart';
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
  final ScrollController _scrollController = ScrollController();
  var _isLoading = false;
  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<InfluencerSearch>(context, listen: false)
        .search(widget.param, widget.query)
        .catchError((error) {})
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        Provider.of<InfluencerSearch>(context, listen: false)
            .searchNext(widget.param, widget.query)
            .catchError((error) {})
            .then((value) {});
      } else {
        print('Not Yet Max');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final influData = Provider.of<InfluencerSearch>(context);
    return Scaffold(
        backgroundColor: Color(0xff1A1A1A),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xfff7f7f7),
          ),
          title: Row(
            children: [
              Text(
                widget.name,
                style: TextStyle(
                  color: Color(0xfff7f7f7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xff1A1A1A),
          elevation: 0,
        ),
        body: Container(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xfff7f7f7),
                  ),
                )
              : influData.items_search.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Not any user found.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xfff7f7f7),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Back',
                              style: TextStyle(color: Color(0xff1a1a1a)),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Color(0xff93deff)),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: influData.items_search.length,
                      controller: _scrollController,
                      separatorBuilder: (context, index) {
                        if ((index + 1) % 10 == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: CustomNativeAds(),
                          );
                        } else {
                          return Container();
                        }
                      },
                      itemBuilder: ((_, i) {
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
                      }),
                    ),
        ));
  }
}
