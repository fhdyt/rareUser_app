import 'package:flutter/material.dart';

class PicScreen extends StatelessWidget {
  final String url;
  const PicScreen({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xfff7f7f7), //change your color here
        ),
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xff1A1A1A),
        elevation: 0,
      ),
      body: Center(
        child: Image.network(
          url,
          width: 400.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
