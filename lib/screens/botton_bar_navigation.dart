import 'package:app_rareuser/screens/country_screen.dart';
import 'package:app_rareuser/screens/home_screen.dart';
import 'package:app_rareuser/screens/social_media_screen.dart';
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
    SocialMediaScreen(),
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
      backgroundColor: Color(0xff1A1A1A),
      body: screens[_currentIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: CustomBannerAds(),
          ),
          SalomonBottomBar(
            unselectedItemColor: Color(0xfff7f7f7),
            currentIndex: _currentIndex,
            onTap: onTapBar,
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Color(0xff93deff),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.person_pin_rounded),
                title: Text("Social Media"),
                selectedColor: Color(0xff93deff),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.pin_drop_rounded),
                title: Text("Country"),
                selectedColor: Color(0xff93deff),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.grid_3x3_outlined),
                title: Text("Tags"),
                selectedColor: Color(0xff93deff),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
