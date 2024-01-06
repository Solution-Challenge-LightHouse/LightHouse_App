import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomnavigationbar;

  const DefaultLayout(
      {required this.child,
      this.backgroundColor,
      this.bottomnavigationbar,
      this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        //null이면 흰색
        appBar: renderAppBar(),
        body: child,
        bottomNavigationBar: bottomnavigationbar);
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        foregroundColor: Colors.black,
      );
    }
  }
}
