import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
        stream: bloc.items,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }

          return FutureBuilder(
              future: snapshot.data[itemId],
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return LoadingContainer();
                }

                return buildTile(context, itemSnapshot.data);
              });
        });
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, "/${item.id}");
        },
        title: Text(item.title),
        subtitle: Text("${item.score} Votes"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.comment),
            Text('${item.descendants}'),
          ],
        ),
      ),
    );
  }
}
