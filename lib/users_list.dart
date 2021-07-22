import 'package:flutter/material.dart';
import 'package:my_app/user_view.dart';
import 'api.dart';

Future<Map<String, List>> getData() async {
  return {
    'users': await getTypicode('/users'),
    'posts': await getTypicode('/posts'),
    'albums': await getTypicode('/albums'),
    'photos': await getTypicode('/photos'),
    'comments': await getTypicode('/comments'),
  };
}

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users list'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, List>> snapshot) {
          final users = snapshot.data?['users'] ?? List.empty();
          final posts = snapshot.data?['posts'] ?? List.empty();
          final albums = snapshot.data?['albums'] ?? List.empty();
          final photos = snapshot.data?['photos'] ?? List.empty();
          final comments = snapshot.data?['comments'] ?? List.empty();

          return ListView.separated(
            padding: const EdgeInsets.all(50),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];

              final userPosts = posts.where((post) => post['userId'] == user['id'])
                  .toList(growable: false);

              final userAlbums = albums.where((album) => album['userId'] == user['id'])
                  .toList(growable: false);

              final userAlbumIds = userAlbums.isNotEmpty ? userAlbums.map((a) => a['id'])
                  .toList(growable: false) : [];

              final userPhotos = userAlbumIds.isNotEmpty ?
                photos.where((photo) => userAlbumIds.contains(photo['albumId'])).toList(growable: false) : [];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserView(
                    user: user,
                    posts: userPosts,
                    getComments: (postId) => comments.where((c) => c['postId'] == postId).toList(growable: false),
                    albums: userAlbums,
                    photos: userPhotos,
                  )));
                },
                child: Text("${user['username']} (${user['name']})", style: TextStyle(fontSize: 22)),
              );
            },
          );
        },
      )
    );
  }
}
