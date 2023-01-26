import 'package:app_rareuser/screens/detail_screen.dart';
import 'package:app_rareuser/widgets/influencer-list-tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/influencer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Influencer>(context, listen: false).fetchData();
  }

  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Influencer>(context, listen: false)
          .fetchData()
          .catchError((error) {})
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final influData = Provider.of<Influencer>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: 30.0,
              fit: BoxFit.contain,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rare User',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                Text(
                  'find the users you want',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                ),
              ],
            ),
          ],
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
          : RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView.builder(
                itemCount: influData.items.length,
                itemBuilder: ((context, i) => InfluencerListTile(
                      influData.items[i].sId.toString(),
                      influData.items[i].name.toString(),
                      influData.items[i].pic.toString(),
                      influData.items[i].desc.toString(),
                      influData.items[i].country!.countryId.toString(),
                      influData.items[i].country!.name.toString(),
                      influData.items[i].gender.toString(),
                      influData.items[i].tags!.toList(),
                    )),
              ),
            ),
    );
  }
}
