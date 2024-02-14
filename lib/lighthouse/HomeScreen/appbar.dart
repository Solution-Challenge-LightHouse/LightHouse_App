import 'package:flutter/material.dart';

AppBar? renderAppBar(String title) {
  return AppBar(
    backgroundColor: const Color(0xFFAC9AF9),
    centerTitle: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
    title: Text(
      title,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
    ),
  );
}
