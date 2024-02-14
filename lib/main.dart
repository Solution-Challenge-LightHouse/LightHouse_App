import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/firebase_options.dart';
import 'package:lighthouse/login/auth.dart';

//다른데 코드 보낼때 구글맵 api 반드시삭제 app/src/main/androidmanifest.xml

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Light House',
    home: Scaffold(
      body: AuthPage(),
    ),
  ));
}
