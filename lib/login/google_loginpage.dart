import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lighthouse/component/button.dart';
import 'package:lighthouse/component/text_field.dart';
import 'package:lighthouse/login/login.dart';

import 'package:lighthouse/login/userdata_register.dart';
import 'package:lighthouse/login/userdata_register2.dart';

class googleLoginPage extends StatefulWidget {
  const googleLoginPage({super.key});

  @override
  State<googleLoginPage> createState() => _Loginpage22State();
}

class _Loginpage22State extends State<googleLoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwTextController = TextEditingController();

    void displaymessage(String message) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(message),
              ));
    }

    //user sign in
    void signIn() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const LoginPage()));
      //show loading circle
      // showDialog(
      //     context: context,
      //     builder: ((context) => const Center(
      //           child: CircularProgressIndicator(),
      //         )));

      // try {
      //   await FirebaseAuth.instance.signInWithEmailAndPassword(
      //       email: emailTextController.text,
      //       password: passwTextController.text);

      //   if (context.mounted) Navigator.pop(context);
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (_) => const Userdataregister()));
      // } on FirebaseException catch (e) {
      //   Navigator.pop(context);
      //   displaymessage(e.code);
      // }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('asset/img/logo/lighthouse.png'),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity, // Container의 너비를 화면 전체로 설정합니다.
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFAC9AF9), // 버튼의 배경색을 검은색으로 설정합니다.
                    padding: const EdgeInsets.all(20), // 버튼의 패딩을 설정합니다.
                    shape: RoundedRectangleBorder(
                      // 버튼의 모양을 설정합니다.
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    _handleSignIn(context);
                  },
                  icon: Image.asset('asset/img/logo/googlelogo.png',
                      height:
                          35.0), // 'assets' 디렉토리에 있는 Google 로고 이미지를 불러옵니다. 필요에 따라 경로를 변경하세요.
                  label: const Text(
                    'Google Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18), // 텍스트 스타일을 설정합니다.
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Mybutton(ontap: signIn, text: 'Login in'),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const Userdataregister2()));
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignIn(BuildContext context) async {
    try {
      // 구글 로그인 시도
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // 로그인 성공
      if (googleUser != null) {
        // 파이어베이스로 로그인 정보 전달
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // 파이어베이스 인증
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // 로그인 성공 후 처리할 작업
          // 예: 홈 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Userdataregister()),
          );
        }
      }
    } catch (error) {
      // 로그인 실패 처리
      print('구글 로그인 실패: $error');
    }
  }
}
