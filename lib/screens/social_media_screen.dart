import 'package:app_rareuser/providers/social_media.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SocialMediaProv>(context, listen: false)
          .fetchData()
          .catchError((error) {
        print(error);
      }).then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socialMediaData = Provider.of<SocialMediaProv>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Social Media',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: socialMediaData.isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : socialMediaData.items.length == 0
                ? Center(
                    child: Text('Not Found'),
                  )
                : Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: socialMediaData.items.length,
                      itemBuilder: ((context, index) => Card(
                            child: ListTile(
                              title: Text(
                                socialMediaData.items[index].name.toString(),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Resultscreen(
                                      param: 'social_media',
                                      query: socialMediaData.items[index].name
                                          .toString(),
                                      name: socialMediaData.items[index].name
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                    ),
                  ),
      ),
    );
  }
}
