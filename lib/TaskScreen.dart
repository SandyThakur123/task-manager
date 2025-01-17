import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager_app/ImagePickerAndloader.dart';
import 'package:task_manager_app/TaskListScreen.dart';
import 'package:task_manager_app/taskEditingScreen.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  String? _description;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            TextField(
              maxLines: 5, // Adjust maximum lines
              minLines: 1, // Keep minimum lines as 1
              controller: _titleController,

              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                onPressed: () async {
                  if (_titleController.text.isNotEmpty) {
                    await saveTask(
                      title: _titleController.text,
                      description: _description,
                      imageUrl: _imageUrl,
                    );
                    //Navigator.pop(context);
                  }
                },
                child: Text(
                  'Save Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.05),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RichTextEditorScreen(
                        onSave: (desc) {
                          setState(() {
                            _description = desc;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Add Description'),
              ),
            ),
            ElevatedButton(
              
              onPressed: () async {
                final uploader = ImagePickerAndUploader();
                final url = await uploader.pickAndUploadImage();
                if (url != null) {
                  setState(() {
                    _imageUrl = url;
                  });
                }
              },
              child: const Text('Upload Image'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskListScreen(),
                  ),
                );
              },
              child: Text('Task List'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveTask({
    required String title,
    String? description,
    String? imageUrl,
  }) async {
    final tasksCollection = FirebaseFirestore.instance.collection('task');
    final taskData = {
      'title': title,
      'description': description ?? '',
      'imageUrl': imageUrl ?? '',
      'completed': false,
      'createdAt': Timestamp.now(),
    };
    await tasksCollection.add(taskData);
  }
}
