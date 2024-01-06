import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/HomeScreen.dart';
import 'package:flutterlogin/login/main_login/colors.dart';
import 'package:flutterlogin/login/main_login/data.dart';
import 'package:flutterlogin/login/main_login/default_layouy.dart';
import 'package:flutterlogin/login/main_login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //deleteToken();
    checkToken();

    //initstate await불가능
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try {
      final resp = await dio.post('http://$ip/auth/token',
          options: Options(headers: {'authorization': 'Bearer $refreshToken'}));

      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false);
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: const Color.fromARGB(255, 172, 154, 249),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
