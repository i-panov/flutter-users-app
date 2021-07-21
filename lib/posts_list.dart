import 'package:flutter/material.dart';
import 'package:my_app/post_preview.dart';

class PostsList extends StatelessWidget {
  final List<Map> data;

  PostsList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User posts'),
      ),
      body: Column(
        children: [ for (var p in data) PostPreview(data: p) ],
      ),
    );
  }
}
