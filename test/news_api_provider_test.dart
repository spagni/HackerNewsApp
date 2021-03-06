import 'package:flutter_news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds Returns List Of Ids', () async {
    final newsApi = NewsApiProvider();

    newsApi.httpClient = MockClient((request) async {
      return Response(json.encode([1,2,3,4,5]), 200);
    });
    
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1,2,3,4,5]);
  });

  test('FetchItem returns an ItemModel', () async {
    final newsApi = NewsApiProvider();
    
    newsApi.httpClient = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}