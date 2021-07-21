import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";
import 'package:collection/collection.dart';

Future<dynamic> getTypicode(String action) async {
  final prefs = await SharedPreferences.getInstance();
  String body;

  if (prefs.containsKey(action)) {
    body = prefs.getString(action)!;
  } else {
    var url = Uri.parse("https://jsonplaceholder.typicode.com$action");
    var response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode != 200) {
      throw new Exception(response.reasonPhrase);
    }

    body = response.body;
    prefs.setString(action, body);
  }

  return json.decode(body);
}

Future<Map> getTypicodeList(String action) async {
  var items = await getTypicode(action);
  var list = new Map<int, Map>();

  for (var item in items) {
    list[item['id']] = item;
  }

  return list;
}

Future<Map> getTypicodeGroupedList(String action, String groupField) async {
  var items = await getTypicode(action);
  var list = new Map<int, Map<int, Map>>();

  for (var item in items) {
    final key = item[groupField] is int ? item[groupField] : int.parse(item[groupField]);

    if (!list.containsKey(key)) {
      list[key] = new Map<int, Map>();
    }

    list[key]![item['id']] = item;
  }

  return list;
}

getUsers() async {
  return getTypicodeList('/users');
}

Future<Map> getUsersWithRelations() async {
  var users = await getUsers();
  var posts = await getPosts();
  var albums = await getAlbums();
  var photos = await getPhotos();

  for (var user in users.values) {
    final userPosts = posts[user['id']] as Map;
    final userAlbums = albums[user['id']] as Map;

    var postPreviewsList = userPosts.values.take(3).map((post) {
      var postCopy = Map.from(post);
      postCopy['body'] = (post['body'].toString().split("\n").firstOrNull ?? '') + '...';
      return postCopy;
    });

    var albumPreviewsList = userAlbums.values.take(3).map((album) {
      var albumCopy = Map.from(album);
      var albumPhotos = photos[album['id']] as Map;
      albumCopy['photo'] = albumPhotos.values.firstOrNull;
      return albumCopy;
    });

    user['postPreviews'] = { for (var p in postPreviewsList) p['id']: p };
    user['albumPreviews'] = { for (var p in albumPreviewsList) p['id']: p };
    user['posts'] = userPosts;
    user['albums'] = userAlbums;
  }

  return users;
}

getPosts() async {
  return getTypicodeGroupedList('/posts', 'userId');
}

getComments() async {
  return getTypicodeGroupedList('/comments', 'postId');
}

getPostComments(int postId) async {
  final comments = await getComments();
  return comments[postId];
}

getAlbums() async {
  return getTypicodeGroupedList('/albums', 'userId');
}

getPhotos() async {
  return getTypicodeGroupedList('/photos', 'albumId');
}

addComment(int postId, String name, String email, String body) async {
  const action = '/comments';
  var url = Uri.parse("https://jsonplaceholder.typicode.com$action");

  var response = await http.post(url, headers: {"Accept": "application/json"}, body: {
    "postId": postId.toString(),
    "name": name,
    "email": email,
    "body": body,
  });

  if (response.statusCode != 201) {
    throw new Exception(response.reasonPhrase);
  }

  final result = json.decode(response.body);
  final prefs = await SharedPreferences.getInstance();
  final commentsString = prefs.containsKey(action) ? prefs.getString(action)! : '[]';
  var comments = json.decode(commentsString);
  comments.add(result);
  prefs.setString(action, json.encode(comments));
  return result;
}
