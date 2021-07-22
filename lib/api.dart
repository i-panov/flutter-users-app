import 'dart:convert';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";

Future<List> getTypicode(String action) async {
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
