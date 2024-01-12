import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp();

  // Firebase 인증 인스턴스 생성
  final FirebaseAuth auth = FirebaseAuth.instance;

  // 로그인 또는 회원가입 로직

  // 로그인이나 회원가입이 완료된 후, 토큰 받아오기
  User? user = auth.currentUser;
  if (user != null) {
    String? token = await user.getIdToken();
    debugPrint('토큰: $token');
  }

  // 앱 실행
  runApp(const Scaffold(
    body: Text('data'),
  ));
}
