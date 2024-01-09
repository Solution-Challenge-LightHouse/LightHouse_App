import 'package:flutter/material.dart';
import 'package:flutterlogin/component/my_list_tile.dart';
import 'package:flutterlogin/lighthouse/community/community_homepage.dart';
import 'package:flutterlogin/lighthouse/profile/profile_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
          )),
          MyListTile(
              icon: Icons.home,
              text: 'H o m e',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfilePage()));
              }),
          MyListTile(
              icon: Icons.person,
              text: 'Profile',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ProfilePage()));
              }),
          const MyListTile(icon: Icons.logout, text: 'Logout', onTap: signOut),
        ],
      ),
    );
  }
}
