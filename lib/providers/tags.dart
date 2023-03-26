import 'dart:convert';

import 'package:app_rareuser/commons/constants.dart';

import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Tags with ChangeNotifier {
  List<String> _item_tags = [];
  List<String> get items_tags {
    return [..._item_tags];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 1;
  int get page => _page;

  bool _maxPage = false;
  bool get maxPage => _maxPage;

  Future<void> allTags() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${Endpoint.baseUrl}/search/tags/all');
    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body);
      _item_tags =
          (extractedData as List).map((tags) => tags.toString()).toList();
      notifyListeners();
    } catch (error) {
      _item_tags = [];
      throw error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
