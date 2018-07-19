import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _respository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Stream getter
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;
  //Sink getter
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentTransformer()).pipe(_commentsOutput);
  }

  _commentTransformer() {
    return ScanStreamTransformer<int,Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        cache[id] = _respository.fetchItem(id);
        cache[id].then((ItemModel item) {
          item.kids.forEach((kidId) => fetchItemWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }


  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}