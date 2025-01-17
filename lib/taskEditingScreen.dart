import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class RichTextEditorScreen extends StatefulWidget {
  final Function(String) onSave;

  const RichTextEditorScreen({required this.onSave});

  @override
  _RichTextEditorScreenState createState() => _RichTextEditorScreenState();
}

class _RichTextEditorScreenState extends State<RichTextEditorScreen> {
  late quill.QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController.basic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: Text('Add Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final jsonDescription = _controller.document.toDelta().toJson();
              widget.onSave(jsonDescription.toString());
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          quill.QuillToolbar.simple(controller: _controller),
          Expanded(child: quill.QuillEditor.basic(controller: _controller, )),
        ],
      ),
    );
  }
}