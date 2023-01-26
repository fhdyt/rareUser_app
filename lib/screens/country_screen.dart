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
  // var _isLoading = false;
  @override
  void initState() {
    // setState(() {
    //   _isLoading = true;
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CountryProv>(context, listen: false)
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
    final countryData = Provider.of<CountryProv>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Country',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: countryData.isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/run.png",
                    width: 400.0,
                    fit: BoxFit.contain,
                  ),
                  CircularProgressIndicator(),
                ],
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
                              leading: Flag.fromString(
                                  countryData.items[index].countryId.toString(),
                                  height: 50,
                                  width: 40),
                              title: Text(
                                countryData.items[index].name.toString(),
                              ),
                              subtitle: Text(
                                countryData.items[index].countryId.toString(),
                              ),
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
