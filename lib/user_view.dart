import 'package:flutter/material.dart';
import 'package:my_app/album_preview.dart';
import 'package:my_app/albums_list.dart';
import 'package:my_app/post_preview.dart';
import 'package:my_app/posts_list.dart';
import 'package:collection/collection.dart';

class UserView extends StatelessWidget {
  final Map user;
  final List posts;
  final List albums;
  final List photos;

  UserView({
    Key? key,
    required this.user,
    required this.posts,
    required this.albums,
    required this.photos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['username']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('name: ' + user['name']),
          Text('email: ' + user['email']),
          Text('phone: ' + user['phone']),
          Text('website: ' + user['website']),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text('Posts: '),
                ...[for (var post in posts.take(3)) PostPreview(post: post) ],
                ElevatedButton(
                  child: Text('All posts'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostsList(posts: posts)));
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
                ...[for (var album in albums.take(3)) AlbumPreview(
                    album: album,
                    photo: photos.firstWhereOrNull((p) => p['albumId'] == album['id']),
                )],
                ElevatedButton(
                  child: Text('All albums'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumsList(albums: albums, photos: photos)));
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
