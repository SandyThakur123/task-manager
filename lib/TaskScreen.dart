import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  // Define the addTask function
 void addTask(String title) async {
  // Get a reference to the 'tasks' node in Firebase
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('tasks');

  // Generate a unique ID for the task
  final String? taskId = dbRef.push().key;
  print("Generated Task ID: $taskId");

  // Create the task data
  final taskData = {
    "title": title,
    "completed": false,
    "createdAt": DateTime.now().toIso8601String(),
  };

  // Save the task to Firebase
  if (taskId != null) {
    try {
      await dbRef.child(taskId).set(taskData);
      print("Task added successfully!");
    } catch (e) {
      print("Error adding task: $e");
    }
  } else {
    print("Failed to generate task ID");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field to enter the task title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Enter Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Button to add the task
            ElevatedButton(
              onPressed: () {
                print(_titleController.text);
                if (_titleController.text.isNotEmpty) {
                  addTask(_titleController.text); // Call the function
                  _titleController.clear(); // Clear the input field
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Task title cannot be empty!')),
                  );
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}