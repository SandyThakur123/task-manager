import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  bool completed;
  Timestamp createdAt;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
        'createdAt': createdAt,
      };

  static Task fromJson(String id, Map<String, dynamic> json) => Task(
        id: id,
        title: json['title'],
        completed: json['completed'] ?? false,
        createdAt: json['createdAt'],
      );
}