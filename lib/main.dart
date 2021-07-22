import 'package:flutter/material.dart';
import 'package:my_app/users_list.dart';

void main() {
  runApp(UsersApp());
}

class UsersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UsersList(),
    );
  }
}
