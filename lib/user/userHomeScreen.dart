import 'package:flutter/material.dart';

import '../task/fb_Con.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                AuthServices.signOut(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: const Center(
        child: Text('User Home'),
      ),
    );
  }
}
