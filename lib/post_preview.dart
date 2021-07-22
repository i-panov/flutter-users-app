import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:my_app/post_view.dart';

class PostPreview extends StatelessWidget {
  final Map post;
  final List Function(int postId) getComments;

  PostPreview({Key? key, required this.post, required this.getComments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 200, height: 200),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostView(post: post, comments: getComments(post['id']))));
        },
        child: Column(
          children: <Widget>[
            Text(post['title'], style: TextStyle(fontWeight: FontWeight.bold)),
            Text((post['body'].toString().split("\n").firstOrNull ?? '') + '...', style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
