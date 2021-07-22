import 'package:flutter/material.dart';
import 'package:my_app/post_preview.dart';

class PostsList extends StatelessWidget {
  final List posts;

  PostsList({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User posts'),
      ),
      body: Column(
        children: [ for (var post in posts) PostPreview(post: post) ],
      ),
    );
  }
}
