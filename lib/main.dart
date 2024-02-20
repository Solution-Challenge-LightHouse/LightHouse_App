import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/firebase_options.dart';
import 'package:lighthouse/login/auth.dart';

//I deleted the personal googlemap API because it is a code that everyone can see.
//You must enter your Googlemap API key to use location services.
//android/app/src/main/androidmanifest.xml

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
