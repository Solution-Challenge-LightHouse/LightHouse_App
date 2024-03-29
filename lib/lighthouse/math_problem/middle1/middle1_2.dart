import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/math_problem/middle1/middle1_1_detail.dart';

class Middle1_2 extends StatefulWidget {
  const Middle1_2({super.key});

  @override
  State<Middle1_2> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<Middle1_2> {
  bool isLoding = true;
  List items = [];
  String id = '';
  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar('Math Problem'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: isLoding,
          replacement: RefreshIndicator(
            onRefresh: fetchTodo,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['id'];
                  int score = item['score'];
                  String scoreStr = score.toString();
                  return GestureDetector(
                    onTap: () {
                      navigateToDetailPage(item, id);
                    },
                    child: Card(
                      color: const Color(0xFFF5F3FF),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: (item['imgPath'] != "" &&
                                  item['imgPath'] != "@@" &&
                                  item['imgPath'] != null)
                              ? Image.network(
                                  item['imgPath'],
                                  fit: BoxFit.fill,
                                )
                              : const SizedBox(),
                        ),
                        subtitle: Text(
                          item['title'] + ' • ' + scoreStr + "점",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Future<void> fetchTodo() async {
    String? accesstoken = await getToken();
    const url = 'http://52.79.242.2:8080/examples/find?grade=1&category=문자와 식';
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      String? accesstoken = await getToken();
      const url =
          'http://52.79.242.2:8080/examples/find?grade=1&category=문자와 식';
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $accesstoken'
      });
      if (response.statusCode == 200) {
        final json = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        final result = json;

        setState(() {
          items = result;
        });
      }
    } else if (response.statusCode == 500) {
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      final result = json;

      setState(() {
        items = result;
      });
    }

    setState(() {
      isLoding = false;
    });
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

  Future<void> navigateToDetailPage(Map item, int id) async {
    final route = MaterialPageRoute(
        builder: (_) => Middle1_1_detail(
              todo: item,
              idid: id,
            ));
    await Navigator.push(context, route);

    setState(() {
      isLoding = true;
    });
    fetchTodo();
  }
}
