import 'package:flutter/material.dart';

class AlbumPreview extends StatelessWidget {
  final Map data;

  AlbumPreview({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 100, height: 100),
      child: Column(
        children: <Widget>[
          Text(data['title']),
          Image.network(data['photo']['thumbnailUrl']),
        ],
      ),
    );
  }
}
