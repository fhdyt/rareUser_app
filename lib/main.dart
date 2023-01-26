import 'package:app_rareuser/models/influencer_model.dart';
import 'package:app_rareuser/providers/country.dart';
import 'package:app_rareuser/providers/influencer.dart';
import 'package:app_rareuser/screens/botton_bar_navigation.dart';
import 'package:app_rareuser/screens/detail_screen.dart';
import 'package:app_rareuser/screens/favorite_screen.dart';
import 'package:app_rareuser/screens/home_screen.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:app_rareuser/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/post_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Influencer(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CountryProv(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Montserrat',
        ),
        // home: BottonBarNavigation(),
        home: SplashScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          DetailScreen.routeName: (ctx) => DetailScreen(),
        },
      ),
    );
  }
}
