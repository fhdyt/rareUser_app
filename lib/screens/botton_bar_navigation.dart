import 'package:app_rareuser/screens/all_post_screen.dart';
import 'package:app_rareuser/screens/country_screen.dart';
import 'package:app_rareuser/screens/home_screen.dart';
import 'package:app_rareuser/screens/tags_screen.dart';
import 'package:app_rareuser/widgets/custom_banner_ads.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottonBarNavigation extends StatefulWidget {
  const BottonBarNavigation({super.key});

  @override
  State<BottonBarNavigation> createState() => _BottonBarNavigationState();
}

class _BottonBarNavigationState extends State<BottonBarNavigation> {
  List screens = [
    HomeScreen(),
    CountryScreen(),
    TagsScreen(),
  ];
  var _currentIndex = 0;

  void onTapBar(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: CustomBannerAds(),
          // ),
          SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: onTapBar,
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Theme.of(context).primaryColor,
              ),
              // SalomonBottomBarItem(
              //   icon: Icon(Icons.grid_on_rounded),
              //   title: Text("Posts"),
              //   selectedColor: Theme.of(context).primaryColor,
              // ),
              SalomonBottomBarItem(
                icon: Icon(Icons.pin_drop_rounded),
                title: Text("Country"),
                selectedColor: Theme.of(context).primaryColor,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.grid_3x3_outlined),
                title: Text("Tags"),
                selectedColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
