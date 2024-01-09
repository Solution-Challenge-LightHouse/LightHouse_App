import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/homescreen.dart';
import 'package:flutterlogin/lighthouse/community/community_homepage.dart';
import 'package:flutterlogin/lighthouse/math_problem/math_problem_main.dart';
import 'package:flutterlogin/lighthouse/profile/profile_page.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

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
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text('LOG OUT'),
              onTap: signOut,
            ),
          )
        ],
      ),
    );
  }
}
