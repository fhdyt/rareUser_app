import 'package:app_rareuser/models/influencer_model.dart';
import 'package:app_rareuser/screens/result_screen.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CountryProv>(context, listen: false)
          .fetchData()
          .catchError((error) {
        print(error);
      }).then((value) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final countryData = Provider.of<CountryProv>(context);
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
              'Country',
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
            : countryData.items.length == 0
                ? Center(
                    child: Text('Not Found'),
                  )
                : Container(
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: countryData.items.length,
                      itemBuilder: ((context, index) => Card(
                            child: ListTile(
                              tileColor: Color(0xff616571),
                              leading: Flag.fromString(
                                  countryData.items[index].countryId.toString(),
                                  height: 50,
                                  width: 40),
                              title: Text(
                                countryData.items[index].name.toString(),
                                style: TextStyle(color: Color(0xfff7f7f7)),
                              ),
                              subtitle: Text(
                                  countryData.items[index].countryId.toString(),
                                  style: TextStyle(color: Color(0xfff7f7f7))),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Resultscreen(
                                      param: 'country',
                                      query: countryData.items[index].sId
                                          .toString(),
                                      name: countryData.items[index].name
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
