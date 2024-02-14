import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/community/add_page.dart';
import 'package:lighthouse/lighthouse/community/comment_edit_page.dart';

class CommunityDetailPage extends StatefulWidget {
  final Map todo;
  int idid;

  CommunityDetailPage({super.key, required this.todo, required this.idid});

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  String answer = '';
  final answerController = TextEditingController();
  bool isLoding = true;
  List items = [];
  bool isLiked = false;

  late int commentid;

  late int id = widget.idid;
  late Map todo;

  Future<void> fetchTodo() async {
    final url = 'http://52.79.242.2:8080/comments/find/${widget.todo['id']}';
    final uri = Uri.parse(url);
    String? accesstoken = await getToken();

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      setState(() {
        items = json;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    String timeinput = widget.todo['creatAt'];
    DateTime parsedDate = DateTime.parse(timeinput);
    String formattedDate = DateFormat('yyyy-MM-dd - HH:mm').format(parsedDate);

    return Scaffold(
      appBar: renderAppBar('Community'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CommentEditPage(id: id)),
          );
        },
        backgroundColor: const Color(0xFFF5F3FF),
        child: const Icon(Icons.comment),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          'https://publicdomainvectors.org/photos/abstract-user-flat-1.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${widget.todo['userName']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Text(' • '),
                              Text(
                                'Level ${widget.todo['userLevel']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          navigateEditPage(widget.todo);
                        } else if (value == 'delete') {
                          deleteById(widget.idid);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ];
                      },
                    ),
                  ),
                  Text(
                    'Title: ${widget.todo['title']}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.todo['content']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.black,
                        ),
                        onPressed: () {
                          likepost();
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                      Text(
                        widget.todo['likeCount'].toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                      Expanded(
                        child: Text(formattedDate),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Comment',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: fetchTodo,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index] as Map;

                    int score = item['userLevel']; // item['score']에 들어있는 정수 값
                    String scoreStr = score.toString();
                    int commentid = item['id'];
                    String commenttimeinput = item['creatAt'];
                    DateTime parsedDate = DateTime.parse(commenttimeinput);
                    String commentformattedDate =
                        DateFormat('yyyy-MM-dd - HH:mm').format(parsedDate);

                    return GestureDetector(
                      onTap: () {
                        // Handle item tap
                      },
                      child: Card(
                        color: const Color(0xFFF5F3FF),
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.network(
                              'https://publicdomainvectors.org/photos/abstract-user-flat-1.png',
                              width: 30, // 원형 이미지의 너비 설정
                              height: 30, // 원형 이미지의 높이 설정
                              fit: BoxFit.cover, // 이미지를 원형 영역에 맞추기 위해 cover로 설정
                            ),
                          ),
                          title: Text(
                              item['userName'] + ' • ' + 'Level ' + scoreStr),
                          subtitle: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item['content'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    Text(
                                      commentformattedDate,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          trailing: SizedBox(
                            width: 20,
                            child: PopupMenuButton(
                              onSelected: (value) {
                                commentdeleteById(commentid);
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteById(int idid) async {
    final url = 'http://52.79.242.2:8080/posts/delete/$idid';
    final uri = Uri.parse(url);
    String? accesstoken = await getToken();

    final response = await http.delete(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['id'] != idid).toList();
      setState(() {
        items = filtered;
        showSuccessMessage('Deletion sucess');
      });
    } else {
      showErrorMessage('Deletion failed');
    }
  }

  Future<void> commentdeleteById(int commentid) async {
    final commentstr = commentid.toString();
    final url = 'http://52.79.242.2:8080/comments/delete/$commentstr';
    final uri = Uri.parse(url);
    String? accesstoken = await getToken();

    final response = await http.delete(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      showSuccessMessage('Deletion sucess');
    } else {
      showErrorMessage('Deletion failed');
    }
  }

  Future<void> likepost() async {
    final url = 'http://52.79.242.2:8080/likes/${widget.todo['id']}';
    final uri = Uri.parse(url);
    String? accesstoken = await getToken();

    final response = await http.post(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
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

  Future<void> navigateEditPage(Map item) async {
    final route = MaterialPageRoute(builder: (_) => AddTodoPage(todo: item));

    await Navigator.push(context, route);
    setState(() {
      isLoding = true;
    });
    fetchTodo();
  }
}
