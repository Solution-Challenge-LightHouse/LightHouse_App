import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:lighthouse/component/text_field.dart';
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';

class Middle2_1_detail extends StatefulWidget {
  final Map todo;
  int idid;

  Middle2_1_detail({super.key, required this.todo, required this.idid});

  @override
  State<Middle2_1_detail> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<Middle2_1_detail> {
  String answer = '';
  final answerController = TextEditingController();
  bool isLoding = true;
  List items = [];
  late int id;
  late Map todo;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchTodo();
  // }

  @override
  Widget build(BuildContext context) {
    int score = widget.todo['score']; // item['score']에 들어있는 정수 값
    String scoreStr = score.toString(); // 정수를 문자열로 변환
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
                        onPressed: () {
                          submitData();
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

                // Add more information as needed
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
    // Correcting the URL string using string interpolation
    final url = 'http://52.79.242.2:8080/submissions/save/${widget.todo['id']}';

    final uri = Uri.parse(url);
    String? accesstoken = await getToken();

    final mathanswer = answerController.text;

    final body = {
      "userAnswer": mathanswer,
    };

    // Uncommenting the HTTP request
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $accesstoken'
      },
    );

    if (response.statusCode == 200) {
      // Check if the submitted answer is correct
      if (mathanswer == widget.todo["correct"]) {
        showSuccessMessage('Correct');
      } else {
        showErrorMessage('wrong');
        print('xxxxxx');
      }
    }
  }
}
