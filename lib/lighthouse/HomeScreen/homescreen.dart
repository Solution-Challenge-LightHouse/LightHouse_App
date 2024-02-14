import 'package:flutter/material.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/lighthouse/HomeScreen/drawer.dart';
import 'package:lighthouse/lighthouse/HomeScreen/homeScreenBottom.dart';
import 'package:lighthouse/lighthouse/HomeScreen/homeScreenTop.dart';
import 'package:lighthouse/lighthouse/community/community_homepage.dart';
import 'package:lighthouse/lighthouse/math_problem/math_problem_main.dart';
import 'package:lighthouse/lighthouse/profile/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const ProfilePage(),
    const mathproblemmain(),
    const HomeScreen(),
    const CommunityHomePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar('Light House'),
      // drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Image.asset('asset/img/logo/lighthouse.png'),
            ),
            const HomeScreenTop(),
            const SizedBox(height: 10),
            const HomeScreenBottom(),
          ],
        ),
      ),
    );
  }
}
