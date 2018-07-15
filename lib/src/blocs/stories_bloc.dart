import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items;

  //Getters to stream
  Observable<List<int>> get topIds => _topIds.stream;
  Function(int) get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{},

    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}