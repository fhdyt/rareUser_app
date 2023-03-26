import 'package:app_rareuser/widgets/incluencer-list-horizontal.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../providers/influencer.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({super.key});

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  var _isInit = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final cekData = Provider.of<Influencer>(context);
      if (cekData.items_top.length == 0) {
        Provider.of<Influencer>(context, listen: false)
            .fetchDataTop()
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
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: influData.items_top.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, i) => InfluencerListHorizontal(
              influData.items_top[i].sId.toString(),
              influData.items_top[i].name.toString(),
              influData.items_top[i].pic.toString(),
              influData.items_top[i].desc.toString(),
              influData.items_top[i].country!.countryId.toString(),
              influData.items_top[i].country!.name.toString(),
              influData.items_top[i].gender.toString(),
              influData.items_top[i].tags!.toList(),
            )),
      ),
    );
  }
}
