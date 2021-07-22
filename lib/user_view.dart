import 'package:flutter/material.dart';
import 'package:my_app/album_preview.dart';
import 'package:my_app/albums_list.dart';
import 'package:my_app/post_preview.dart';
import 'package:my_app/posts_list.dart';

class UserView extends StatelessWidget {
  final Map user;
  final List posts;
  final List Function(int postId) getComments;
  final List albums;
  final List Function(int albumId) getPhotos;

  UserView({
    Key? key,
    required this.user,
    required this.posts,
    required this.getComments,
    required this.albums,
    required this.getPhotos,
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
          Text('company: ' + ['name', 'catchPhrase', 'bs'].map((key) => user['company'][key]).join(', ')),
          Text('address: ' + ['city', 'street', 'suite'].map((key) => user['address'][key]).join(', ')),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text('Posts: '),
                ...[for (var post in posts.take(3)) PostPreview(post: post, getComments: getComments) ],
                ElevatedButton(
                  child: Text('All posts'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostsList(posts: posts, getComments: getComments)));
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
                ...[for (var album in albums.take(3)) AlbumPreview(album: album, getPhotos: getPhotos)],
                ElevatedButton(
                  child: Text('All albums'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumsList(albums: albums, getPhotos: getPhotos)));
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
