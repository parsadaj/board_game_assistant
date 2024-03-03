// group.dart

import 'dart:convert';

class Group {
  late String name;
  late List<String> members;

  Group({
    required this.name,
    required this.members,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      name: json['name'],
      members: List<String>.from(json['members']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'members': members,
    };
  }
}
