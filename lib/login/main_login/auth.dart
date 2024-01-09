import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/homescreen.dart';
import 'package:flutterlogin/lighthouse/community/community_homepage.dart';
import 'package:flutterlogin/login/main_login/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginorRegister();
          }
        },
      ),
    );
  }
}
