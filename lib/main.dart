import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/auth.dart';
import 'package:flutterlogin/login/main_login/auth.dart';

void main() async {
  // Flutter 바인딩 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    home: Scaffold(
      body: AuthPage2(),
    ),
  ));
}
