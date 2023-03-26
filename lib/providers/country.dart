import 'dart:convert';

import '../commons/constants.dart';
import '../models/country_model.dart';
import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CountryProv with ChangeNotifier {
  List<CountryModel> _item = [];
  List<CountryModel> get items {
    return [..._item];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${Endpoint.baseUrl}/country');

    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List;
      final loadedCountry = extractedData.map((countryData) {
        return CountryModel(
          sId: countryData['_id'],
          name: countryData['name'],
          countryId: countryData['country_id'],
        );
      }).toList();

      _item = loadedCountry;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
