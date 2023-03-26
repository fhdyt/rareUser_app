import 'dart:convert';

import 'package:app_rareuser/commons/constants.dart';

import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class InfluencerDetail with ChangeNotifier {
  List<InfluencerModel> _item_detail = [];
  List<InfluencerModel> get items_detail {
    return [..._item_detail];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _detailShow = 0;
  int get detailShow => _detailShow;

  Future<void> detail(String args) async {
    if (_detailShow == 5) {
      _detailShow = 1;
    } else {
      _detailShow += 1;
    }
    final url = Uri.parse('${Endpoint.baseUrl}/influencer/${args}');
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
