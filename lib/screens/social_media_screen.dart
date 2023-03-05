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
      backgroundColor: Color(0xff1A1A1A),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xfff7f7f7), //change your color here
        ),
        backgroundColor: Color(0xff1A1A1A),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Social Media',
              style: TextStyle(
                  color: Color(0xfff7f7f7), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: socialMediaData.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xfff7f7f7),
                ),
              )
            : socialMediaData.items.length == 0
                ? Center(
                    child: Text('Not Found'),
                  )
                : Container(
                    width: double.infinity,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: socialMediaData.items.length,
                        itemBuilder: ((context, index) => InkWell(
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
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff1A1A1A),
                                    border: Border.all(
                                      color: Color(0xfff7f7f7),
                                      width: 2,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: socialMediaData.items[index].name ==
                                          'Tiktok'
                                      ? Image.asset(
                                          "assets/images/social_media/Tiktok.png",
                                          fit: BoxFit.contain,
                                        )
                                      : socialMediaData.items[index].name ==
                                              'Instagram'
                                          ? Image.asset(
                                              "assets/images/social_media/Instagram.png",
                                              fit: BoxFit.contain,
                                            )
                                          : socialMediaData.items[index].name ==
                                                  'Facebook'
                                              ? Image.asset(
                                                  "assets/images/social_media/Facebook.png",
                                                  fit: BoxFit.contain,
                                                )
                                              : socialMediaData
                                                          .items[index].name ==
                                                      'Bigo'
                                                  ? Image.asset(
                                                      "assets/images/social_media/Bigo.png",
                                                      fit: BoxFit.contain,
                                                    )
                                                  : socialMediaData.items[index]
                                                              .name ==
                                                          'Youtube'
                                                      ? Image.asset(
                                                          "assets/images/social_media/Youtube.png",
                                                          fit: BoxFit.contain,
                                                        )
                                                      : socialMediaData
                                                                  .items[index]
                                                                  .name ==
                                                              'Twitter'
                                                          ? Image.asset(
                                                              "assets/images/social_media/Twitter.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : Image.asset(
                                                              "assets/images/logo.png",
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                ),
                              ),
                            ))),
                  ),
      ),
    );
  }
}
