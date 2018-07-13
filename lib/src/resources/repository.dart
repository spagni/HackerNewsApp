import 'dart:async';
import '../models/item_model.dart';
import './news_api_provider.dart';
import './news_db_provider.dart';

class Repository {
  NewsApiProvider apiProvider = new NewsApiProvider();
  NewsDbProvider dbProvider = NewsDbProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    dbProvider.init();
    var item = await dbProvider.fetchItem(id);

    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    //lo guardo en sqlite
    dbProvider.addItem(item);

    return item;
  }
}