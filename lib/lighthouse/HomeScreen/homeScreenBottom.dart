import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/community/community_homepage.dart';
import 'package:flutterlogin/lighthouse/profile/profile_page.dart';

class HomeScreenBottom extends StatelessWidget {
  const HomeScreenBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CommunityHomePage()));
              },
              child: const Text(
                'Community',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              )),
          const Text('  •  '),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfilePage()));
              },
              child: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],

        // Container(
        //     height: 300,
        //     width: 600,
        //     decoration: BoxDecoration(
        //         color: const Color(0xFFF5F3FF),
        //         borderRadius: BorderRadius.circular(10)))
      ),
    );
  }
}
