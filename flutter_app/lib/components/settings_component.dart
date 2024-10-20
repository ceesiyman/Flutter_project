import 'package:flutter/material.dart';

class SettingsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.settings, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is the settings page component.', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}