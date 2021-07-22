import 'package:flutter/material.dart';
import 'package:my_app/network_proxy_image.dart';

class AlbumView extends StatelessWidget {
  final Map album;
  final List photos;

  AlbumView({Key? key, required this.album, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album'),
      ),
      body: Column(
        children: <Widget>[
          Text(album['title'], style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(50),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: photos.length,
              itemBuilder: (BuildContext context, int index) {
                final photo = photos[index];
                return Column(
                  children: <Widget>[
                    Text(photo['title'], style: TextStyle(fontStyle: FontStyle.italic)),
                    NetworkProxyImage(src: photo['url']),
                  ],
                );
              }
          )),
        ],
      ),
    );
  }
}
