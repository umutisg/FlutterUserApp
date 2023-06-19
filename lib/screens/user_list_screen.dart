import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:user_app/models/user.dart';
import 'package:user_app/screens/user_details_screen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    final List<dynamic> responseData = json.decode(response.body);

    setState(() {
      users = responseData
          .map((user) => User(
                id: user['id'],
                name: user['name'],
                email: user['email'],
                address: Address.fromJson(user['address']),
                company: Company.fromJson(user['company']),
                phone: user['phone'],
                username: user['username'],
                website: user['website'],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, 
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.only(top: 170),
            itemCount: users.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              );
            },
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) =>
                          UserDetailsScreen(userId: users[index].id),
                    ),
                  );
                },
                child: ListTile(
                  leading: const CircleAvatar(),
                  title: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(users[index].name),
                  ),
                  subtitle: Container(
                    child: Text(users[index].company.bs),
                  ),
                  trailing: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5A0FC8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        users[index].id.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 155,
              decoration: const BoxDecoration(
                color: Color(0xFF7B3FD3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'USERS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
