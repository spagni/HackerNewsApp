import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final children = <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: (depth + 1)*16.0, right: 16.0),
              title: _buildText(snapshot.data),
              subtitle: snapshot.data.by != '' ?Text(snapshot.data.by) : Text('Deleted'),
            ),
            Divider()            
          ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });
        return Column(
          children: children,
        );
      },
    );
  }

  Widget _buildText(ItemModel item) {
    final text = item.text
                  .replaceAll('&#x27;', "'")
                  .replaceAll('<p>', '\n\n')
                  .replaceAll('</p>', '');
    return Text(text);
  }
}