import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client httpClient = new Client();

  Future<List<int>> fetchTopIds() async {
    final response = await httpClient.get('$_root/v0/topstories.json');
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await httpClient.get('$_root/v0/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}