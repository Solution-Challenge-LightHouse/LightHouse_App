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
      body: Column(
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
    );
  }
}
