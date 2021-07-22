import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PostPreview extends StatelessWidget {
  final Map post;

  PostPreview({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 200, height: 200),
      child: Column(
        children: <Widget>[
          Text(post['title'], style: TextStyle(fontWeight: FontWeight.bold)),
          Text((post['body'].toString().split("\n").firstOrNull ?? '') + '...', style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
