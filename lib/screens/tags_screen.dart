import 'package:app_rareuser/models/influencer_model.dart';
import 'package:app_rareuser/providers/influencer.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Influencer>(context, listen: false)
          .allTags()
          .catchError((error) {
        print(error);
      }).then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final countryData = Provider.of<Influencer>(context);
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
              'Tags',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: countryData.isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : countryData.items.length == 0
                ? Center(
                    child: Text('Not Found'),
                  )
                : Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: countryData.items_tags.length,
                      itemBuilder: ((context, index) => Card(
                            child: ListTile(
                              title: Text(
                                  '#${countryData.items_tags[index].toString()}'),
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
                            ),
                          )),
                    ),
                  ),
      ),
    );
  }
}
