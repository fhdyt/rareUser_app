import 'package:app_rareuser/screens/botton_bar_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    Future.delayed(const Duration(seconds: 2)).then((val) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottonBarNavigation()),
      );
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Color(0xff1A1A1A),

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 170,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 30,
                ),
                // Text(
                //   'Rare User',
                //   style: TextStyle(fontSize: 30, color: Colors.white),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
