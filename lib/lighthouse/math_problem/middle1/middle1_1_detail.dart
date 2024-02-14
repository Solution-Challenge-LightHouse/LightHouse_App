import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lighthouse/component/text_field.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';

class Middle1_1_detail extends StatefulWidget {
  final Map todo;
  int idid;

  Middle1_1_detail({super.key, required this.todo, required this.idid});

  @override
  State<Middle1_1_detail> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<Middle1_1_detail> {
  String answer = '';
  final answerController = TextEditingController();
  bool isLoding = true;
  List items = [];
  late int id;
  late Map todo;

  @override
  Widget build(BuildContext context) {
    int score = widget.todo['score'];
    String scoreStr = score.toString();
    return Scaffold(
      appBar: renderAppBar('Community'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${widget.todo['title']}',
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                Visibility(
                  visible: widget.todo['imgPath'] != "",
                  child: SizedBox(
                    width: 600,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.todo['imgPath'],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  '${widget.todo['content']}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 15),
                Visibility(
                    visible: widget.todo['multipleChoice'] != "",
                    child: Text(
                      '${widget.todo['multipleChoice']}',
                      style: const TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "$scoreStr점",
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(
                    children: [
                      MyTextField(
                        controller: answerController,
                        hintText: 'answer',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await submitData();
                        },
                        child: Text(
                          'submit',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 30),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showSuccessMessage('hi');
                        },
                        child: Text(
                          'submit',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    final mathanswer = answerController.text;

    final body = {
      "mathanswer": mathanswer,
    };

    final url =
        'https://52.79.242.2:8080/submissions/save/${widget.todo['id']}';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body));

    if (response.statusCode == 201) {
      showSuccessMessage('Correct!');
    } else {
      showErrorMessage('Wrong!');
    }
  }

  void showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
