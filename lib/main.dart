import 'package:app_rareuser/providers/country.dart';
import 'package:app_rareuser/providers/influencer.dart';
import 'package:app_rareuser/providers/post.dart';
import 'package:app_rareuser/routes/route.dart';
import 'package:app_rareuser/screens/favorite_screen.dart';
import 'package:app_rareuser/screens/home_screen.dart';
import 'package:app_rareuser/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
        ),
        ChangeNotifierProvider(
          create: (ctx) => PostProv(),
        )
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) => RouteGenerate.generateRoute(settings),
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Montserrat',
        ),
        // home: BottonBarNavigation(),
        home: SplashScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          // DetailScreen.routeName: (ctx) => DetailScreen(),
        },
      ),
    );
  }
}
