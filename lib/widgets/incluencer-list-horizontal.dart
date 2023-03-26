import 'package:app_rareuser/routes/route.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class InfluencerListHorizontal extends StatelessWidget {
  final String sId;
  final String name;
  final String pic;
  final String desc;
  final String country;
  final String country_name;
  final String gender;
  final List<String> tags;

  InfluencerListHorizontal(this.sId, this.name, this.pic, this.desc,
      this.country, this.country_name, this.gender, this.tags);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "Detail",
            arguments: ModelRoute(id: sId, gender: gender));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Positioned(
                child: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: FadeInImage.assetNetwork(
                      image: pic,
                      placeholder: "assets/images/icon2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              gender == 'male'
                  ? Positioned(
                      child: Icon(
                        Icons.male_rounded,
                        color: Colors.blue,
                      ),
                    )
                  : Positioned(
                      child: Icon(Icons.female_rounded, color: Colors.pink),
                    ),
            ]),
            Container(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xfff7f7f7),
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade, //new
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
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
          ],
        ),
      ),
    );
  }
}
