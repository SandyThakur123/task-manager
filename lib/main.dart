import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager_app/TaskScreen.dart';

import 'Model/TaskModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddTaskScreen(),
      
    );
  }
}

// class TaskScreen extends StatelessWidget {
//   final TextEditingController _titleController = TextEditingController();

//   // Add task to Firestore
//   void addTask(String title) async {
//     final tasksCollection = FirebaseFirestore.instance.collection('task');

//     final taskData = {
//       "title": title,
//       "completed": false,
//       "createdAt": FieldValue.serverTimestamp(),
//     };

//     try {
//       await tasksCollection.add(taskData);
//       print("Task added successfully!");
//     } catch (e) {
//       print("Error adding task: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tasksCollection = FirebaseFirestore.instance.collection('task');
//     return Scaffold(
//       appBar: AppBar(title: Text('Task Manager')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Task Title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 if (_titleController.text.isNotEmpty) {
//                   addTask(_titleController.text); // Add task to Firestore
//                   _titleController.clear(); // Clear input field
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Task title cannot be empty!')),
//                   );
//                 }
//               },
              
//               child: Text('Add Task'),
//             ),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: tasksCollection
//                     .orderBy('createdAt', descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return Center(child: Text('No tasks found.'));
//                   }

//                   final tasks = snapshot.data!.docs.map((doc) {
//                     final data = doc.data() as Map<String, dynamic>;
//                     return Task.fromJson(doc.id, data);
//                   }).toList();

//                   return ListView.builder(
//                     itemCount: tasks.length,
//                     itemBuilder: (context, index) {
//                       final task = tasks[index];
//                       return ListTile(
//                         title: Text(
//                           task.title,
//                           style: task.completed
//                               ? TextStyle(
//                                   decoration: TextDecoration.lineThrough)
//                               : null,
//                         ),
//                         trailing: Checkbox(
//                           value: task.completed,
//                           onChanged: (value) async {
//                             await tasksCollection
//                                 .doc(task.id)
//                                 .update({'completed': value});
//                           },
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
