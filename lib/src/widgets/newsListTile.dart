import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import './loading_container.dart';

class NewsListTiles extends StatelessWidget {
  final int itemId;
  NewsListTiles({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if(!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          leading: _buildHero(),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}')
            ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          }  
        ),
        Divider( height: 6.0)
      ],
    );
  }

  Widget _buildHero() {
    return Hero(
      tag: 'hero-tag-$itemId',
      child: Icon(Icons.code),
    );
  }
}