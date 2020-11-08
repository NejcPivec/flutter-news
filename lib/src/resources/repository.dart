import 'dart:async';
import '../models/item_model.dart';
import 'news_api_provider.dart';
import 'news_db_provider.dart';

class Repository {
  /* NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider(); */

  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];

  List<Cache> cashes = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    /* var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item; */

    ItemModel item;
    var source;

    /* Find id */
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    /* Add to db */
    for (var cache in cashes) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for (var cache in cashes) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}
