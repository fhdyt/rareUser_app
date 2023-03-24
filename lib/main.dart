import 'package:app_rareuser/providers/country.dart';
import 'package:app_rareuser/providers/influencer.dart';
import 'package:app_rareuser/providers/post.dart';
import 'package:app_rareuser/providers/social_media.dart';
import 'package:app_rareuser/routes/route.dart';
import 'package:app_rareuser/screens/favorite_screen.dart';
import 'package:app_rareuser/screens/home_screen.dart';
import 'package:app_rareuser/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("8331de78-9fbf-4241-adca-2cf14df967ee");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        ),
        ChangeNotifierProvider(
          create: (ctx) => SocialMediaProv(),
        )
      ],
      child: MaterialApp(
        onGenerateRoute: (settings) => RouteGenerate.generateRoute(settings),
        title: 'Rare User',
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
