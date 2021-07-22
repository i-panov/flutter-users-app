import 'package:flutter/material.dart';
import 'package:my_app/network_proxy_image.dart';

class AlbumPreview extends StatelessWidget {
  final Map album;
  final Map? photo;

  AlbumPreview({Key? key, required this.album, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 100, height: 100),
      child: Column(
        children: <Widget>[
          Text(album['title']),
          NetworkProxyImage(src: photo?['thumbnailUrl'] ?? 'https://via.placeholder.com/150/ffffff/000000?text=No+Photo'),
        ],
      ),
    );
  }
}
