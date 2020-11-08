import 'package:flutter/material.dart';
import 'package:news/src/screens/news_detail.dart';
import 'package:news/src/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          // extract the item id from settings.name and pass to NewsDetail
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          // Initial data fetching
          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}
