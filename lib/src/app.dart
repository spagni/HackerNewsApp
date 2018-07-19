import 'package:flutter/material.dart';
import './screens/news_list.dart';
import 'screens/news_detail.dart';
import 'blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
          title: 'NEWS',
          onGenerateRoute: routes,
        ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) => NewsList()
      );
    }
    else {
      final itemId = int.parse(settings.name.replaceFirst('/', ''));
      return MaterialPageRoute(
        builder: (context) => NewsDetail(itemId: itemId)
      );
    }
  }
}