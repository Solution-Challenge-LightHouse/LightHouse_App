import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/HomeScreen.dart';
import 'package:flutterlogin/login/main_login/colors.dart';
import 'package:flutterlogin/login/main_login/custom_text_field.dart';
import 'package:flutterlogin/login/main_login/data.dart';
import 'package:flutterlogin/login/main_login/default_layouy.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
        child: SingleChildScrollView(
      //드레그하면 키보드 내려감
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(child: _Title()),
              Image.asset(
                'asset/img/misc/logo.png',
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                hintText: '이메일을 입력해주세요',
                onChanged: (String value) {
                  username = value;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                hintText: '비밀번호를 입력해주세요',
                onChanged: (String value) {
                  password = value;
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  final rawString = '$username:$password';

                  //string값 넣고 string값 받겠다. //걍 암기 파트 스트링->base64
                  Codec<String, String> stringToBase64 = utf8.fuse(base64);

                  String token = stringToBase64.encode(rawString);

                  final resp = await dio.post(
                    'http://$ip/auth/login',
                    options: Options(
                      headers: {'authorization': 'Basic $token'},
                    ),
                  );

                  final refreshToken = resp.data['refreshToken'];
                  final accessToken = resp.data['accessToken'];

                  await storage.write(
                      key: REFRESH_TOKEN_KEY, value: refreshToken);
                  await storage.write(
                      key: ACCESS_TOKEN_KEY, value: accessToken);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 172, 154, 249)),
                child: const Text(
                  '로그인',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () async {},
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: const Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다',
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
    );
  }
}
