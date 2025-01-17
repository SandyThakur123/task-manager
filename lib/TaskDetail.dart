import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    late quill.Document descriptionDocument;

    // Parse description from Firestore
    if (task['description'] != null) {
      try {
        if (task['description'] is String) {
          // Parse String into List<dynamic> for Quill
          final parsedDescription = jsonDecode(task['description'].toString());
          descriptionDocument = quill.Document.fromJson(parsedDescription);
        } else if (task['description'] is List<dynamic>) {
          // Already in List<dynamic> format
          descriptionDocument =
              quill.Document.fromJson(task['description'] as List<dynamic>);
        } else {
          throw Exception('Invalid description format');
        }
      } catch (e) {
        print('Error parsing description: $e');
        // Create a default empty Quill document if parsing fails
        descriptionDocument = quill.Document();
      }
    } else {
      // Default empty Quill document if no description is provided
      descriptionDocument = quill.Document();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: Colors.white,
        elevation: 2,
        title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${task['title']}',
                style: const TextStyle(fontSize: 18)),
             SizedBox(height: 16),
            // const Text('Description:', style: TextStyle(fontSize: 16)),
            Text('Description: ${task['description']==null?'No description':task['description']}',
                style: const TextStyle(fontSize: 18)),
             SizedBox(height: 16),
            if (task['imageUrl'] != null && task['imageUrl'].isNotEmpty)
              Image.network(task['imageUrl']),
             SizedBox(height: 16),
            GestureDetector(
              onTap: () {
              print('${{task['createdAt'].toDate()}}');
              },
              child: Text('Created At: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(task['createdAt'].toDate().toString()))}')),
          ],
        ),
      ),
    );
  }
}
