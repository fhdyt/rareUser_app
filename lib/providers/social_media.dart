import 'dart:convert';

import 'package:app_rareuser/models/social_media_model.dart';

import '../commons/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SocialMediaProv with ChangeNotifier {
  List<SocialMediaModel> _item = [];
  List<SocialMediaModel> get items {
    return [..._item];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${Endpoint.baseUrl}/social_media');

    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List;
      final loadedCountry = extractedData.map((socialMediaData) {
        return SocialMediaModel(
          sId: socialMediaData['_id'],
          name: socialMediaData['name'],
        );
      }).toList();

      _item = loadedCountry;
      print(response.body);
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
