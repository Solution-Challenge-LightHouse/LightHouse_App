import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/appbar.dart';

import 'package:flutterlogin/lighthouse/HomeScreen/drawer.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/homeScreenBottom.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/homeScreenTop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      drawer: const drawer(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeScreenTop(),
          SizedBox(height: 10),
          HomeScreenBottom(),
        ],
      ),
    );
  }
}
