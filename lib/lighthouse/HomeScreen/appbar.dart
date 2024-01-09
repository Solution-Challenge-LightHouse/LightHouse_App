import 'package:flutter/material.dart';

AppBar? renderAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFF674AEF),
    centerTitle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    title: const Text(
      'Light House',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
    ),
    // actions: [
    //   IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),]
  );
}
