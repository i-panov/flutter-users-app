import 'package:flutter/material.dart';
import 'package:my_app/album_preview.dart';

class AlbumsList extends StatelessWidget {
  final List<Map> data;

  AlbumsList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User albums'),
      ),
      body: Column(
        children: [ for (var p in data) AlbumPreview(data: p) ],
      ),
    );
  }
}
