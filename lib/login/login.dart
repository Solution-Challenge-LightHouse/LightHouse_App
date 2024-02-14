import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lighthouse/component/button.dart';
import 'package:lighthouse/component/text_field.dart';
import 'package:lighthouse/data.dart';

import 'package:lighthouse/login/userdata_register.dart';
import 'package:lighthouse/login/userdata_register2.dart';
import 'package:lighthouse/root_tab.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _Loginpage22State();
}

class _Loginpage22State extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwTextController = TextEditingController();

  Future<void> registerlogin() async {
    final useremail = emailTextController.text;
    final userpassword = passwTextController.text;

    final body = {
      "email": useremail,
      "password": userpassword,
      // "is_completed": false,
    };
    const url = 'http://52.79.242.2:8080/auth/login';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final accessToken = jsonResponse['accessToken'];
      print(accessToken);
      setToken(accessToken);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const RootTab()));
    } else if (response.statusCode == 500) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const Userdataregister2()));
      print(response.statusCode);
    }
  }

  void setToken(String token) {
    storage.write(key: ACCESS_TOKEN_KEY, value: token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    void displaymessage(String message) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(message),
              ));
    }

    //user sign in

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('Welcome back'),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: passwTextController,
                  hintText: 'Password',
                  obscureText: true),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  registerlogin();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const RootTab()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.grey[500], fontSize: 30),
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
