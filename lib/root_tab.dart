// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lighthouse/lighthouse/HomeScreen/homescreen.dart';
import 'package:lighthouse/lighthouse/community/community_homepage.dart';
import 'package:lighthouse/lighthouse/math_problem/math_problem_main.dart';
import 'package:lighthouse/lighthouse/profile/profile_page.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await _navigatorKeys[_currentIndex].currentState!.maybePop(),
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(const ProfilePage(), _navigatorKeys[0], 0),
            _buildOffstageNavigator(
                const CommunityHomePage(), _navigatorKeys[1], 1),
            _buildOffstageNavigator(const HomeScreen(), _navigatorKeys[2], 2),
            _buildOffstageNavigator(
                const mathproblemmain(), _navigatorKeys[3], 3),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color(0xFFAC9AF9),
          unselectedItemColor: Colors.grey,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined), label: 'PROFILE'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'COMMUNITY'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(
                icon: Icon(Icons.ballot_outlined), label: 'MATH PROBLEM'),
          ],
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(
      Widget page, GlobalKey<NavigatorState> navigatorKey, int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => page,
          );
        },
      ),
    );
  }
}
