import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Divider(),
                        Text(
                          'At Rare User application, we are committed to protecting the privacy of our users. Our mobile application allows users to connect with talented individuals from all over the world, but we do not collect any personal data from our users.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Our application does not collect or store any personal information such as name, address, phone number, or email address. We do not track or collect any location data or browsing history.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'We do not share any user data with any third parties. Any data that is collected through the use of our application is solely for the purpose of providing the service offered by our application.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'We take the security of our users data seriously and have implemented measures to protect against unauthorized access, alteration, disclosure, or destruction of data.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'If you have any questions or concerns about our privacy policy, please do not hesitate to contact us.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'By using our application, you consent to our privacy policy.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
