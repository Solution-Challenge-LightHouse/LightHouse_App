import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/community/community_detailpage.dart';
import 'package:lighthouse/lighthouse/community/community_homepage.dart';
import 'package:lighthouse/lighthouse/profile/profile_page.dart';
import 'package:http/http.dart' as http;

class HomeScreenBottom extends StatefulWidget {
  const HomeScreenBottom({super.key});

  @override
  State<HomeScreenBottom> createState() => _HomeScreenBottomState();
}

class _HomeScreenBottomState extends State<HomeScreenBottom> {
  List items = [];
  String id = '';

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Popular Posts',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 1000,
            decoration: BoxDecoration(
                color: const Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length > 5 ? 5 : items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item['id'];

                  int score = item['userLevel'];
                  String scoreStr = score.toString();
                  return Card(
                    color: const Color(0xFFF5F3FF),
                    child: ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          'https://lh3.googleusercontent.com/a/ACg8ocJlVb_4GRzIlla4thKfZtCmBfUXR8MBXA7tB99ffiCN6A=s96-c',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item['title']),
                      subtitle: Text(item['userName'] +
                          (" • ") +
                          "Level " +
                          scoreStr.toString()),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
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
      setState(() {
        items = json; // items 업데이트
      });
    }
  }

  Future<void> navigateToDetailPage(Map item, int id) async {
    final route = MaterialPageRoute(
      builder: (_) => CommunityDetailPage(
        todo: item,
        idid: id,
      ),
    );
    await Navigator.push(context, route);
    // 상세 정보 페이지에서 돌아왔을 때 다시 데이터를 불러오도록 설정
  }
}
