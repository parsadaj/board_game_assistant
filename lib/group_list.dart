// lib/group_list.dart

import 'package:flutter/material.dart';
import 'group.dart';

class GroupList extends StatelessWidget {
  final List<Group> groups;

  GroupList({required this.groups});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(groups[index].name),
          onTap: () {
            // Implement functionality to view/edit group details
          },
        );
      },
    );
  }
}
