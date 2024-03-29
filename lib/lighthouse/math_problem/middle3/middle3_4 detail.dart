import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lighthouse/component/text_field.dart';
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';

class Middle3_4_detail extends StatefulWidget {
  final Map todo;
  int idid;

  Middle3_4_detail({super.key, required this.todo, required this.idid});

  @override
  State<Middle3_4_detail> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<Middle3_4_detail> {
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
      appBar: renderAppBar('Math Problem'),
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
                  visible: widget.todo['imgPath'] != "" &&
                      widget.todo['imgPath'] != null,
                  child: SizedBox(
                    width: 600,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: widget.todo['imgPath'] != null
                          ? Image.network(widget.todo['imgPath'])
                          : Container(),
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

  Future<void> submitData() async {
    final url = 'http://52.79.242.2:8080/submissions/save/${widget.todo['id']}';

    final uri = Uri.parse(url);
    String? accesstoken = await getToken();

    final mathanswer = answerController.text;

    final body = {
      "userAnswer": mathanswer,
    };

    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $accesstoken'
      },
    );

    if (response.statusCode == 200) {
      if (mathanswer == widget.todo["correct"]) {
        showSuccessMessage('Correct');
      } else {
        showErrorMessage('wrong');
        print('xxxxxx');
      }
    }
  }
}
