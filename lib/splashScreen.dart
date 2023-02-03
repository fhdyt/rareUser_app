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
    Future.delayed(const Duration(seconds: 3)).then((val) {
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
                Image.asset(
                  "assets/images/rareuser.png",
                  width: 130,
                  fit: BoxFit.contain,
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
