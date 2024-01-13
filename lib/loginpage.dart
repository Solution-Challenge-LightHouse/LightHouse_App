import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/homescreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Loginpage22 extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Loginpage22({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            _handleSignIn(context);
          },
          icon: const Icon(Icons.login),
          label: const Text('구글 로그인'),
        ),
        const SizedBox(height: 16),
      ],
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
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } catch (error) {
      // 로그인 실패 처리
      print('구글 로그인 실패: $error');
    }
  }
}
