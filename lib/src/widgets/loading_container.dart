import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: buildContainer(),
        subtitle: buildContainer(),
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
    );
  }
}

/*  return Card(
      child: ListTile(
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
    ); */
