import 'package:app_rareuser/providers/influencer.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tags.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Tags>(context, listen: false)
          .allTags()
          .catchError((error) {})
          .then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final countryData = Provider.of<Tags>(context);
    return Scaffold(
        backgroundColor: Color(0xff1A1A1A),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xfff7f7f7),
          ),
          backgroundColor: Color(0xff1A1A1A),
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Tags',
                style: TextStyle(
                    color: Color(0xfff7f7f7), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: countryData.isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Color(0xfff7f7f7)),
                )
              : countryData.items_tags.length == 0
                  ? Center(
                      child: Text('Not Found'),
                    )
                  : ListView.builder(
                      itemCount: countryData.items_tags.length,
                      itemBuilder: ((context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Resultscreen(
                                      param: 'tags',
                                      query: countryData.items_tags[index],
                                      name: countryData.items_tags[index],
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
                                    width: 1.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    '#${countryData.items_tags[index].toString()}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xfff7f7f7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
        ));
  }
}
