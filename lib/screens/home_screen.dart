import 'package:app_rareuser/widgets/influencer-list-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      final cekData = Provider.of<Influencer>(context);
      if (cekData.items.length == 0) {
        Provider.of<Influencer>(context, listen: false)
            .fetchData()
            .catchError((error) {})
            .then((value) {
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final influData = Provider.of<Influencer>(context);
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   TextButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => InfoScreen(),
        //         ),
        //       );
        //     },
        //     child: Icon(
        //       Icons.info,
        //       color: Colors.black,
        //     ),
        //   ),
        // ],
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xff1A1A1A),

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/rareuser_w.png",
              width: 120,
              fit: BoxFit.contain,
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Rare User',
            //       style: TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.w700),
            //     ),
            //     Text(
            //       'find the users you want',
            //       style: TextStyle(color: Colors.black, fontSize: 10),
            //     ),
            //   ],
            // ),
          ],
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
          : Padding(
              padding: const EdgeInsets.only(top: 5),
              child: RefreshIndicator(
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
            ),
    );
  }
}
