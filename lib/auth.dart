import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/homescreen.dart';
import 'package:flutterlogin/login/main_login/login_page.dart';
import 'package:flutterlogin/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

class AuthPage2 extends StatefulWidget {
  const AuthPage2({super.key});

  @override
  State<AuthPage2> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage2> {
  // Firebase 인증 인스턴스 생성
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    User? user = auth.currentUser;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            sendTokenToServer();

            return const HomeScreen();
          } else {
            return Loginpage22();
          }
        },
      ),
    );
  }

  Future<void> sendTokenToServer() async {
    String? token = await _firebaseMessaging.getToken();
    print('토큰값$token');
    // 서버의 엔드포인트 URL
    var url = 'https://example.com/token';

    // POST 요청으로 전달할 데이터
    var data = {'token': token};

    try {
      // HTTP POST 요청 보내기
      var response = await http.post(Uri.parse(url), body: data);

      // 응답 확인
      if (response.statusCode == 200) {
        print('토큰이 성공적으로 서버로 전달되었습니다.');
      } else {
        print('서버로 토큰 전달에 실패했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('서버로 토큰 전달 중 오류가 발생했습니다: $error');
    }
  }
}
