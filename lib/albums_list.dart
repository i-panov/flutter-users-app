import 'package:flutter/material.dart';
import 'package:my_app/album_preview.dart';

class AlbumsList extends StatelessWidget {
  final List albums;
  final List Function(int albumId) getPhotos;

  AlbumsList({Key? key, required this.albums, required this.getPhotos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User albums'),
      ),
      body: Column(
        children: [ for (var album in albums) AlbumPreview(
          album: album,
          getPhotos: getPhotos,
        )],
      ),
    );
  }
}
