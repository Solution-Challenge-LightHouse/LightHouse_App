import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lighthouse/data.dart';

class CommentEditPage extends StatefulWidget {
  final int? id;

  const CommentEditPage({this.id, super.key});

  @override
  State<CommentEditPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<CommentEditPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'description'),
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: submitData,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('submit'),
              ))
        ],
      ),
    );
  }

  Future<void> submitData() async {
    String? accesstoken = await getToken();
    final description = descriptionController.text;
    final body = {
      "content": description,
    };
    final url = 'http://52.79.242.2:8080/comments/save/${widget.id}';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });

    if (response.statusCode == 200) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage('creation success');
    } else {
      showErrorMessage('creation failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
