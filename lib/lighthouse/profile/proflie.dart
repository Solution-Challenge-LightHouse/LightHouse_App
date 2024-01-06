import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/appbar.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/drawer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: renderAppBar(),
      drawer: drawer(),
      body: Container(),
    );
  }
}
