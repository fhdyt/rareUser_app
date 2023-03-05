import 'package:app_rareuser/routes/route.dart';
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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "Detail",
              arguments: ModelRoute(id: sId, gender: gender));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Container(
                  height: 75,
                  width: 75,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.network(
                      pic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xfff7f7f7),
                            ),
                          ),
                          Icon(Icons.female_rounded, color: Colors.pink)
                        ],
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
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xfff7f7f7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: double.infinity,
                        height: 26,
                        // padding: EdgeInsets.only(top: 5),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: tags.length,
                          itemBuilder: ((context, index) => Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: ElevatedButton(
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
                                            color: Color(0xff1a1a1a)),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        backgroundColor: Color(0xff93deff),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     gender == 'male'
              //         ? Icon(
              //             Icons.male_rounded,
              //             color: Colors.blue,
              //           )
              //         : Icon(Icons.female_rounded, color: Colors.pink),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
