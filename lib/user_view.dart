import 'package:flutter/material.dart';
import 'package:my_app/album_preview.dart';
import 'package:my_app/albums_list.dart';
import 'package:my_app/post_preview.dart';
import 'package:my_app/posts_list.dart';

class UserView extends StatelessWidget {
  final Map data;

  UserView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['username']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('name: ' + data['name']),
          Text('email: ' + data['email']),
          Text('phone: ' + data['phone']),
          Text('website: ' + data['website']),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text('Posts: '),
                ...[for (var p in data['posts'].values.take(3)) PostPreview(data: p) ],
                ElevatedButton(
                  child: Text('All posts'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostsList(data: data['posts'].values.toList())));
                  },
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text('Albums: '),
                ...[for (var p in data['albumPreviews'].values) AlbumPreview(data: p) ],
                ElevatedButton(
                  child: Text('All albums'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumsList(data: data['albums'].values.toList())));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
