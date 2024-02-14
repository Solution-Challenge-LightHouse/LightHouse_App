import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:lighthouse/lighthouse/HomeScreen/homescreen.dart';
import 'package:lighthouse/lighthouse/community/community_homepage.dart';
import 'package:lighthouse/lighthouse/math_problem/math_problem_main.dart';
import 'package:lighthouse/lighthouse/profile/profile_page.dart';
import 'package:lighthouse/login/google_loginpage.dart';

class drawer extends StatelessWidget {
  drawer({
    super.key,
  });

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('PROFILE'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfilePage()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('HOME'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('COMMUNITY'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CommunityHomePage()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: const Icon(Icons.ballot_outlined),
              title: const Text('MATH PROBLEM'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const mathproblemmain()));
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 25),
          //   child: ListTile(
          //     leading: const Icon(Icons.logout),
          //     title: const Text('LOG OUT'),
          //     onTap: () {
          //       handleSignOut();
          //       Navigator.of(context).pushAndRemoveUntil(
          //           MaterialPageRoute(builder: (_) => const LoginPage()),
          //           (Route<dynamic> route) => false);
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Future<void> handleSignOut() async {
    try {
      // 구글 로그아웃
      await _googleSignIn.signOut();

      // 파이어베이스 로그아웃
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      print('로그아웃 실패: $error');
    }
  }
}
