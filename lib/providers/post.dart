import 'dart:convert';

import 'package:app_rareuser/models/post_model.dart';

import '../commons/constants.dart';
import '../models/country_model.dart';
import '../models/influencer_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PostProv with ChangeNotifier {
  List<PostModel> _item = [];
  List<PostModel> get items {
    return [..._item];
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('${Endpoint.baseUrl}/posts');

    try {
      final response = await http.get(url);
      final extractedData = jsonDecode(response.body) as List;
      final loadedPosts = extractedData.map((postsData) {
        return PostModel(
          url: postsData['url'],
          source: postsData['source'],
          file: postsData['file'],
          thumbnail: postsData['thumbnail'],
          sId: postsData['_id'],
          userId: postsData['user_id'],
        );
      }).toList();

      _item = loadedPosts;
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
