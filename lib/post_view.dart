import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/comment_form.dart';

class PostView extends StatelessWidget {
  final Map post;
  final List comments;

  PostView({Key? key, required this.post, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Column(
        children: <Widget>[
          Text(post['title'], style: TextStyle(fontWeight: FontWeight.bold)),
          Text(post['body'], style: TextStyle(fontStyle: FontStyle.italic)),
          Divider(),
          Expanded(child: ListView.separated(
              padding: const EdgeInsets.all(50),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                final comment = comments[index];

                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(comment['email'], style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(': '),
                        Text(comment['name'], style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                    Text(comment['body']),
                  ],
                );
              }
          )),
          Divider(),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(context: context, builder: (context) => CommentForm());
            },
            child: Text('Добавить комментарий'),
          )
        ],
      ),
    );
  }
}
