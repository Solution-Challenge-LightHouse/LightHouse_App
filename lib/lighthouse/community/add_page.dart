import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lighthouse/data.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;

  const AddTodoPage({this.todo, super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['content'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Post' : 'Add Post'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 20,
          ),
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
              onPressed: isEdit ? updatedata : submitData,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(isEdit ? 'Update' : 'submit'),
              ))
        ],
      ),
    );
  }

  Future<void> updatedata() async {
    String? accesstoken = await getToken();
    final todo = widget.todo;
    if (todo == null) {
      print('you can not call updated without todo data');
      return;
    }
    final id = todo['id'];
    String strid = id.toString();
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "content": description,
    };

    final url = 'http://52.79.242.2:8080/posts/update/$strid';
    final uri = Uri.parse(url);
    final response = await http.patch(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });

    if (response.statusCode == 200) {
      showSuccessMessage('updation success');
    } else {
      showErrorMessage('updation failed');
    }
  }

  Future<void> submitData() async {
    String? accesstoken = await getToken();
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "content": description,
    };
    const url = 'http://52.79.242.2:8080/posts/save';
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
