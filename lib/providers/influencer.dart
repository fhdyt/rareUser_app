import 'dart:convert';

import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Influencer with ChangeNotifier {
  List<InfluencerModel> _item = [];
  List<InfluencerModel> get items {
    return [..._item];
  }

  List<InfluencerModel> _item_search = [];
  List<InfluencerModel> get items_search {
    return [..._item_search];
  }

  List<InfluencerModel> _item_detail = [];
  List<InfluencerModel> get items_detail {
    return [..._item_detail];
  }

  Future<void> fetchData() async {
    final url = Uri.parse('https://rareuser.goldenisland.id/influencer');

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
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> search(String param, String query) async {
    final url =
        Uri.parse('https://rareuser.goldenisland.id/search/${param}/${query}');
    try {
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

  Future<void> detail(String args) async {
    final url =
        Uri.parse('https://rareuser.goldenisland.id/influencer/${args}');
    try {
      final response = await http.get(url);
      final List<InfluencerModel> loaded = [];
      final extractedData = jsonDecode(response.body) as List;
      final detail_item = extractedData.map((influencerData) {
        final platformExtract = influencerData['platforms'] as List;
        final postExtract = influencerData['posts'] as List;
        return InfluencerModel(
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
          platforms: platformExtract.map(
            (platformData) {
              return Platforms(
                platform: platformData['platform'],
                username: platformData['username'],
                link: platformData['link'],
                sId: platformData['_id'],
              );
            },
          ).toList(),
          posts: postExtract.map(
            (postsData) {
              return Posts(
                url: postsData['url'],
                source: postsData['source'],
                file: postsData['file'],
                thumbnail: postsData['thumbnail'],
              );
            },
          ).toList(),
        );
      }).toList();
      _item_detail = detail_item;
      notifyListeners();
    } catch (error) {
      _item_detail = [];
      throw error;
    }
  }
}
