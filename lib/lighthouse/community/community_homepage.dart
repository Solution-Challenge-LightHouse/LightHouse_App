import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/community/add_page.dart';
import 'package:lighthouse/lighthouse/community/community_detailpage.dart';

//https://api.nstack.in/#/

class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({super.key});

  @override
  State<CommunityHomePage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<CommunityHomePage> {
  bool isLoding = true;
  List items = [];
  String id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchTodo();
  }
  //즉, 이 코드는 isLoding 변수의 값에 따라 보여줄 내용을 결정하는데, isLoding이 true이면 자식 위젯을 보여주고, false이면 RefreshIndicator를 보여줍니다.
  //사용자가 RefreshIndicator를 '당기면' fetchTodo 함수를 호출하여 새로운 데이터를 가져옵니다

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar('Community'),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToaddPage, label: const Text('Add post')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: isLoding,
          replacement: RefreshIndicator(
            onRefresh: fetchTodo,
            child: ListView.builder(
                itemCount: items.length,
                // 각 항목 사이에 Divider를 추가합니다.
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['id'];
                  int score = item['userLevel']; // item['score']에 들어있는 정수 값
                  String scoreStr = score.toString();

                  return GestureDetector(
                    onTap: () {
                      // ListTile을 탭할 때의 동작을 정의합니다.
                      // 여기서는 상세 정보 페이지로 이동하도록 예시로 작성했습니다.
                      navigateToDetailPage(item, id);
                    },
                    child: Card(
                      color: const Color(0xFFF5F3FF),
                      child: ListTile(
                        leading: ClipOval(
                          child: Image.network(
                            'https://publicdomainvectors.org/photos/abstract-user-flat-1.png',
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover, // 이미지를 원형 영역에 맞추기 위해 cover로 설정
                          ),
                        ),
                        title: Text(item['title']),
                        subtitle: Text(
                            item['userName'] + " • " + "Level " + scoreStr),
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

  // Future<String?> getToken() async {
  //   String? token = await storage.read(key: ACCESS_TOKEN_KEY);
  //   return token;
  // }

  Future<void> navigateEditPage(Map item) async {
    final route = MaterialPageRoute(builder: (_) => AddTodoPage(todo: item));

    await Navigator.push(context, route);
    setState(() {
      isLoding = true;
    });
    fetchTodo();
  }

  Future<void> navigateToaddPage() async {
    final route = MaterialPageRoute(builder: (_) => const AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoding = false;
    });
  }

  Future<void> deleteById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage('Deletion failed');
    }
  }

  Future<void> fetchTodo() async {
    const url = 'http://52.79.242.2:8080/posts/find/list/all';
    final uri = Uri.parse(url);
    String? accesstoken = await getToken();
    print(accesstoken);

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
        builder: (_) => CommunityDetailPage(
              todo: item,
              idid: id,
            ));
    await Navigator.push(context, route);
    // 상세 정보 페이지에서 돌아왔을 때 다시 데이터를 불러오도록 설정
    setState(() {
      isLoding = true;
    });
    fetchTodo();
  }
}
