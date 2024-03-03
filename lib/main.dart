// lib/main.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'group.dart';
import 'group_list.dart';

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
      home: GroupListScreen(),
    );
  }
}

class GroupListScreen extends StatefulWidget {
  @override
  _GroupListScreenState createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  List<Group> groups = [];
  Group? selectedGroup;
  bool shufflePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton(
          value: selectedGroup,
          onChanged: (newValue) {
            setState(() {
              selectedGroup = newValue as Group?;
            });
          },
          items: groups.map<DropdownMenuItem<Group>>((Group group) {
            return DropdownMenuItem<Group>(
              value: group,
              child: Text(group.name),
            );
          }).toList(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (selectedGroup == null) {
                _showNoGroupSelectedDialog(context);
              } else {
                _showRenameGroupDialog(context);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              if (selectedGroup == null) {
                _showNoGroupSelectedDialog(context);
              } else {
                _showDeleteGroupDialog(context);
              }
            },
          ),
        ],
      ),
      body: selectedGroup != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemCount: selectedGroup!.members.length + 1,
                    itemBuilder: (context, index) {
                      if (index < selectedGroup!.members.length) {
                        return MemberTile(
                          memberNumber: index + 1,
                          memberName: selectedGroup!.members[index],
                          isFirstPlayer: shufflePressed && index == 0,
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Add new member',
                            ),
                            onSubmitted: (String memberName) {
                              setState(() {
                                selectedGroup!.members.add(memberName);
                              });
                            },
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      if (index == selectedGroup!.members.length) {
                        return Divider(
                          height: 0,
                        );
                      } else {
                        return Divider();
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          selectedGroup!.members.shuffle();
                          shufflePressed = true;
                        });
                      },
                      tooltip: 'Shuffle Members',
                      child: Icon(Icons.shuffle),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text('No group selected'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String groupName = '';
              return AlertDialog(
                title: Text('Enter Group Name'),
                content: TextField(
                  onChanged: (value) {
                    groupName = value;
                  },
                  decoration: InputDecoration(hintText: 'Group Name'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Create'),
                    onPressed: () {
                      // Create the group and add it to the list
                      if (groupName.isNotEmpty) {
                        Group newGroup = Group(name: groupName, members: []);
                        setState(() {
                          groups.add(newGroup);
                          selectedGroup = newGroup; // Select the newly created group
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Add Group',
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNoGroupSelectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Group Selected'),
          content: Text('Please select a group before renaming or deleting.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showRenameGroupDialog(BuildContext context) {
    String newGroupName = selectedGroup!.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rename Group'),
          content: TextField(
            onChanged: (value) {
              newGroupName = value;
            },
            decoration: InputDecoration(hintText: 'New Group Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedGroup!.name = newGroupName;
                });
                Navigator.of(context).pop();
              },
              child: Text('Rename'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteGroupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Group'),
          content: Text('Are you sure you want to delete the group "${selectedGroup!.name}"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  groups.remove(selectedGroup);
                  selectedGroup = null;
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MemberTile extends StatelessWidget {
  final int memberNumber;
  final String memberName;
  final bool isFirstPlayer;

  MemberTile({
    required this.memberNumber,
    required this.memberName,
    required this.isFirstPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            '$memberNumber. $memberName',
            style: isFirstPlayer ? TextStyle(fontWeight: FontWeight.bold) : null,
          ),
          if (isFirstPlayer) Text(' (First Player)', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
