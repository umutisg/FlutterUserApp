import 'package:flutter/material.dart';
import 'package:user_app/screens/user_list_screen.dart';

void main() {
  runApp(UserApp());
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      
      home: UserListScreen(),
    );
  }
}
