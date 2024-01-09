import 'package:flutter/material.dart';
import 'package:flutterlogin/login/main_login/login_page.dart';
import 'package:flutterlogin/login/main_login/register_page.dart';

class LoginorRegister extends StatefulWidget {
  const LoginorRegister({super.key});

  @override
  State<LoginorRegister> createState() => _LoginorRegisterState();
}

class _LoginorRegisterState extends State<LoginorRegister> {
  //initially , show login page
  bool showLoginPage = true;

  //toglebetween login and register page
  void togglePagers() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePagers);
    } else {
      return RegisterPage(onTap: togglePagers);
    }
  }
}
