import 'package:flutter/material.dart';
import 'friend_group.dart';

void main() {
  runApp(BoardGameAssistantApp());
}

class BoardGameAssistantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board Game Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FriendGroup> friendGroups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board Game Assistant'),
      ),
      body: ListView.builder(
        itemCount: friendGroups.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(friendGroups[index].name),
            onTap: () {
              // Add functionality to switch to the selected group
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewGroup(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _createNewGroup(BuildContext context) {
    // Show a dialog to create a new friend group
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New Group'),
        content: TextField(
          decoration: InputDecoration(labelText: 'Group Name'),
          onChanged: (value) {
            // Handle changes in group name
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Add functionality to create a new friend group
              setState(() {
                // Add the new friend group to the list
                String groupName = ''; // Get the group name from the text field
                FriendGroup newGroup = FriendGroup(groupName, []);
                friendGroups.add(newGroup);
              });
              Navigator.of(context).pop();
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }
}
