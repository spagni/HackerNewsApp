import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client httpClient = new Client();

  Future<List<int>> fetchTopIds() async {
    final response = await httpClient.get('$_root/topstories.json');
    final ids = json.decode(response.body);
    //Cast devuelve una copia de la lista pero le dice que los elementos van a ser del tipo int
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await httpClient.get('$_root/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}