import 'package:flutter/material.dart';

class HelpComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.help, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text('Help & Support', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('This is the help page component.', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}