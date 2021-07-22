import 'package:flutter/material.dart';
import 'package:my_app/album_view.dart';
import 'package:my_app/network_proxy_image.dart';
import 'package:collection/collection.dart';

class AlbumPreview extends StatelessWidget {
  final Map album;
  final List Function(int albumId) getPhotos;

  AlbumPreview({Key? key, required this.album, required this.getPhotos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photos = getPhotos(album['id']);
    final previewUrl = photos.firstOrNull?['thumbnailUrl'] ?? 'https://via.placeholder.com/150/ffffff/000000?text=No+Photo';

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumView(album: album, photos: photos))),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 200, height: 200),
        child: Column(
          children: <Widget>[
            Text(album['title']),
            NetworkProxyImage(src: previewUrl),
          ],
        ),
      ),
    );
  }
}
