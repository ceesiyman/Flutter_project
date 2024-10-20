import 'package:flutter/material.dart';

class ProfileComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.person, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text('User Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is the profile page component.', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}