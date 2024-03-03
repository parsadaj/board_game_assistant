// lib/add_group_screen.dart

import 'package:flutter/material.dart';

class AddGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Friend Group'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter group name',
              ),
              onChanged: (value) {
                // Implement functionality to update group name
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Implement functionality to add group
              },
              child: Text('Add Group'),
            ),
          ],
        ),
      ),
    );
  }
}
