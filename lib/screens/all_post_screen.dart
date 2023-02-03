import 'package:app_rareuser/models/influencer_model.dart';
import 'package:app_rareuser/providers/post.dart';
import 'package:app_rareuser/screens/post_screen.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country.dart';

class AllPostScreen extends StatefulWidget {
  const AllPostScreen({super.key});

  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {
  // var _isLoading = false;
  @override
  void initState() {
    // setState(() {
    //   _isLoading = true;
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostProv>(context, listen: false)
          .fetchData()
          .catchError((error) {
        print(error);
      }).then((value) {
        // setState(() {
        //   _isLoading = false;
        // });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<PostProv>(context);
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
              'Posts',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: postsData.isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : postsData.items.length == 0
                ? Center(
                    child: Text('Not Found'),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: postsData.items.length,
                    itemBuilder: ((context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostScreen(
                                    url:
                                        postsData.items[index].file.toString()),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: Image.network(
                                  postsData.items[index].thumbnail.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ),
      ),
    );
  }
}
