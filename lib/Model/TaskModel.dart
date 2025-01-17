import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  String imageUrl;
  bool completed;
  Timestamp createdAt;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.imageUrl = '',
    this.completed = false,
    required this.createdAt,
  });

  // Convert Task object to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'completed': completed,
      'createdAt': createdAt,
    };
  }

  // Create Task object from Firestore map
  factory Task.fromJson(String id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      completed: json['completed'] ?? false,
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}
