import 'dart:convert';

import 'package:app_rareuser/commons/constants.dart';

import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Influencer with ChangeNotifier {
  List<InfluencerModel> _item = [];
  List<InfluencerModel> get items {
    return [..._item];
  }

  List<InfluencerModel> _item_top = [];
  List<InfluencerModel> get items_top {
    return [..._item_top];
  }

  List<InfluencerModel> _item_related = [];
  List<InfluencerModel> get items_related {
    return [..._item_related];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 1;
  int get page => _page;

  bool _maxPage = false;
  bool get maxPage => _maxPage;

  Future<void> fetchData() async {
    final url = Uri.parse('${Endpoint.influencer}?page=1');
    if (_item.isEmpty) {
      try {
        final response = await http.get(url);
        final List<InfluencerModel> loadedProducts = [];
        final extractedData = json.decode(response.body);

        extractedData.forEach((influencerData) {
          loadedProducts.add(InfluencerModel(
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
        _item = loadedProducts;
      } catch (error) {
        throw error;
      }
      // _isLoading = false;
      // notifyListeners();
    }
  }

  Future<void> fetchDataNext() async {
    if (_maxPage) {
    } else {
      _page += 1;
      notifyListeners();

      final url = Uri.parse('${Endpoint.influencer}?page=${page}');
      try {
        final response = await http.get(url);
        if (response.body == "[]") {
          _page -= 1;
          _maxPage = true;
        } else {}
        final List<InfluencerModel> loadedProducts = [];
        final extractedData = json.decode(response.body);
        extractedData.forEach((influencerData) {
          loadedProducts.add(InfluencerModel(
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
        _item += loadedProducts;
        // _item.add(loadedProducts);
      } catch (error) {
        throw error;
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchDataTop() async {
    final url = Uri.parse('${Endpoint.baseUrl}/search/influencer/top');
    if (_item_top.isEmpty) {
      try {
        final response = await http.get(url);
        final List<InfluencerModel> loadedProducts = [];
        final extractedData = json.decode(response.body);

        extractedData.forEach((influencerData) {
          loadedProducts.add(InfluencerModel(
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
        _item_top = loadedProducts;
      } catch (error) {
        throw error;
      }
      // _isLoading = false;
      // notifyListeners();
    }
  }

  Future<void> related(String args) async {
    final url = Uri.parse('${Endpoint.baseUrl}/influencer/related/${args}');

    try {
      final response = await http.get(url);
      final List<InfluencerModel> loadedProducts = [];
      final extractedData = json.decode(response.body);

      extractedData.forEach((influencerData) {
        loadedProducts.add(InfluencerModel(
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
      _item_related = loadedProducts;
    } catch (error) {
      throw error;
    }
    _isLoading = false;
    notifyListeners();
  }
}
