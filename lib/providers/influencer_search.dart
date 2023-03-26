import 'dart:convert';

import 'package:app_rareuser/commons/constants.dart';

import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class InfluencerSearch with ChangeNotifier {
  List<InfluencerModel> _item_search = [];
  List<InfluencerModel> get items_search {
    return [..._item_search];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 1;
  int get page => _page;

  bool _maxPage = false;
  bool get maxPage => _maxPage;

  Future<void> search(String param, String query) async {
    final url =
        Uri.parse('${Endpoint.baseUrl}/search/${param}/${query}?page=1');
    try {
      _page = 1;
      _maxPage = false;

      final response = await http.get(url);
      final List<InfluencerModel> loadedSearch = [];
      final extractedData = jsonDecode(response.body);
      extractedData.forEach((influencerData) {
        loadedSearch.add(InfluencerModel(
          sId: influencerData['_id'],
          name: influencerData['name'],
          pic: influencerData['pic'],
          desc: influencerData['desc'],
          country: Country(
            influencerData['country']['name'],
            influencerData['country']['country_id'],
          ),
          gender: influencerData['gender'],
          tags: (influencerData['tags'] as List)
              .map((tags) => tags.toString())
              .toList(),
        ));
      });
      _item_search = loadedSearch;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> searchNext(String param, String query) async {
    if (_maxPage) {
    } else {
      _page += 1;
      notifyListeners();
      final url = Uri.parse(
          '${Endpoint.baseUrl}/search/${param}/${query}?page=${page}');
      try {
        final response = await http.get(url);
        if (response.body == "[]") {
          _page -= 1;
          _maxPage = true;
        } else {}
        final List<InfluencerModel> loadedSearch = [];
        final extractedData = jsonDecode(response.body);
        extractedData.forEach((influencerData) {
          loadedSearch.add(InfluencerModel(
            sId: influencerData['_id'],
            name: influencerData['name'],
            pic: influencerData['pic'],
            desc: influencerData['desc'],
            country: Country(
              influencerData['country']['name'],
              influencerData['country']['country_id'],
            ),
            gender: influencerData['gender'],
            tags: (influencerData['tags'] as List)
                .map((tags) => tags.toString())
                .toList(),
          ));
        });
        _item_search += loadedSearch;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }
}
