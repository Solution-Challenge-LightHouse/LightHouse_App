import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:lighthouse/data.dart';
import 'package:lighthouse/login/google_loginpage.dart';
import 'package:lighthouse/login/login.dart';
import 'dart:developer';

import 'package:lighthouse/login/userdata_register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Firebase 인증 인스턴스 생성
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    determinePosition();
    User? user = auth.currentUser;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          //user is logged in
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중에 인디케이터 표시
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            // sendTokenToServer();

            return const Userdataregister();
          } else {
            return const googleLoginPage();
          }
        },
      ),
    );
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스가 활성화되어 있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 위치 서비스가 꺼져 있다면 활성화 요청
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // 사용자가 위치 서비스를 활성화하지 않으면 처리
        return Future.error('Location services are disabled.');
      }
    }

    // 위치 권한 확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 위치 권한이 거부되었다면 권한 요청
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 사용자가 위치 권한을 거부하면 처리
        return Future.error('Location permissions are denied');
      }
    }

    // 위치 권한이 영원히 거부된 경우
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // 위치 권한이 허용되었다면 현재 위치 가져오기
    final position = await Geolocator.getCurrentPosition();
    LatLng initialcameraposition = const LatLng(20.5937, 78.9629);

    initialcameraposition = LatLng(position.latitude, position.longitude);
  }

  void setToken(String token) {
    storage.write(key: ACCESS_TOKEN_KEY, value: token);
    print(token);
  }

//   Future<void> setToken(String token) async {
//   await storage.write(key: ACCESS_TOKEN_KEY, value: token);
// }

  // Future<void> sendTokenToServer() async {
  //   final User? user = auth.currentUser;
  //   final String? token = await user?.getIdToken();
  //   final dio = Dio();
  //   final resp = await dio.post(
  //     'http://34.168.23.37:8080/',
  //     options: Options(
  //       headers: {'authorization': 'Bearer $token'},
  //     ),
  //   );
  // }
}
