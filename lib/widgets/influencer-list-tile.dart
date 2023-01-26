import 'package:app_rareuser/screens/detail_screen.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../screens/pic_screen.dart';

class InfluencerListTile extends StatelessWidget {
  final String sId;
  final String name;
  final String pic;
  final String desc;
  final String country;
  final String country_name;
  final String gender;
  final List<String> tags;

  InfluencerListTile(this.sId, this.name, this.pic, this.desc, this.country,
      this.country_name, this.gender, this.tags);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName, arguments: sId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(pic),
                  maxRadius: 40,
                  minRadius: 15,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PicScreen(url: pic),
                    ),
                  );
                },
              )),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flag.fromString(country, height: 15, width: 15),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          country_name,
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Text(desc),
                  Container(
                    width: double.infinity,
                    height: 26,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: tags.length,
                        itemBuilder: ((context, index) => Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //     context, Resultscreen.routeName,
                                    //     arguments: tags[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Resultscreen(
                                          param: 'tags',
                                          query: tags[index],
                                          name: tags[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '#${tags[index]}',
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder()),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                gender == 'male'
                    ? Icon(
                        Icons.male_rounded,
                        color: Colors.blue,
                      )
                    : Icon(Icons.female_rounded, color: Colors.pink),
              ],
            )
          ],
        ),
      ),
    );
  }
}
