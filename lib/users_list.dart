import 'package:flutter/material.dart';
import 'package:my_app/user_view.dart';
import 'api.dart';

class UsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users list'),
      ),
      body: FutureBuilder(
        future: getUsersWithRelations(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          List<dynamic> users;

          if (snapshot.hasData) {
            users = snapshot.data!.values.toList(growable: false);
          } else {
            users = List.empty();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(50),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserView(data: users[index])));
                },
                child: Text("${users[index]['username']} (${users[index]['name']})", style: TextStyle(fontSize: 22)),
              );
            },
          );
        },
      )
    );
  }
}
