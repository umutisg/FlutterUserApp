import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:user_app/models/user.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  UserDetailsScreen({required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.9);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users/${widget.userId}'));
    final responseData = json.decode(response.body);

    setState(() {
      user = User(
        id: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        address: Address.fromJson(responseData['address']),
        company: Company.fromJson(responseData['company']),
        phone: responseData['phone'],
        username: responseData['username'],
        website: responseData['website'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: -300,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: EllipseClipper(),
            child: Container(
              height: 600,
              decoration: const BoxDecoration(
                color: Color(0xFFAD87E4),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 60,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user != null)
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsetsDirectional.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Username:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(user!.username),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Full Name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(user!.name),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsetsDirectional.only(bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Website',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(user!.website),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 7),
                                child: const Text(
                                  'Company',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 7),
                                child: Text(
                                  user!.company.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsetsDirectional.only(
                                    bottom: 10),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Catch Phrase:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(user!.company.catchPhrase),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 7),
                                child: const Text(
                                  'Contract',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 7),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Phone:',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(user!.phone),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsetsDirectional.only(bottom: 7),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Email:',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(user!.email),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Address:',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(user!.address.city),
                                  const Text(", "),
                                  Text(user!.address.street),
                                  const Text(", "),
                                  Text(user!.address.suite),
                                  const Text(", "),
                                ],
                              ),
                              Text(user!.address.zipcode),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (user == null)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    ));
  }
}
