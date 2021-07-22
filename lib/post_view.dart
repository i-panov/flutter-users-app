import 'package:flutter/material.dart';

class PostView extends StatelessWidget {
  final Map post;
  final List comments;

  PostView({Key? key, required this.post, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Column(
        children: <Widget>[
          Text(post['title'], style: TextStyle(fontWeight: FontWeight.bold)),
          Text(post['body'], style: TextStyle(fontStyle: FontStyle.italic)),
          Text(comments.toString()),
        ],
      ),
    );
  }
}
