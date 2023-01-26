import 'package:app_rareuser/screens/botton_bar_navigation.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              "assets/images/splash.png",
              width: 400.0,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_w.png",
                  width: 27,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Rare User',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
