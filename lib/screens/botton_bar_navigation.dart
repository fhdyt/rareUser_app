import 'package:app_rareuser/screens/country_screen.dart';
import 'package:app_rareuser/screens/favorite_screen.dart';
import 'package:app_rareuser/screens/home_screen.dart';
import 'package:app_rareuser/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottonBarNavigation extends StatefulWidget {
  const BottonBarNavigation({super.key});

  @override
  State<BottonBarNavigation> createState() => _BottonBarNavigationState();
}

class _BottonBarNavigationState extends State<BottonBarNavigation> {
  List screens = [
    HomeScreen(),
    SearchScreen(),
    CountryScreen(),
    FavoriteScreen()
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
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: onTapBar,
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Theme.of(context).primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search_rounded),
            title: Text("Search"),
            selectedColor: Theme.of(context).primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.flag),
            title: Text("Country"),
            selectedColor: Theme.of(context).primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.bookmark_border_rounded),
            title: Text("Favorites"),
            selectedColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
