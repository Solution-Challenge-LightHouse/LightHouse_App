import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lighthouse/component/text_field.dart';
import 'package:lighthouse/data.dart';
import 'package:lighthouse/login/login.dart';

import 'package:lighthouse/root_tab.dart';

class Userdataregister2 extends StatefulWidget {
  const Userdataregister2({super.key});

  @override
  State<Userdataregister2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Userdataregister2> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String compoundCode = '';
  final usernameController = TextEditingController();
  final userageController = TextEditingController();
  final userschooleController = TextEditingController();
  final userpasswordController = TextEditingController();
  final useridController = TextEditingController();
  String role = '';
  String token = '';
  Map<String, dynamic> googletoken = {};

  String useremail = '';
  String username = '';
  String userepictureurl = '';
  String userlocation = '';

  @override
  void initState() {
    super.initState();
    getplaceaddress();
    printUserToken();
    _initUserDetails();
  }

  Future<void> _printCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    print('Current location: ${position.latitude}, ${position.longitude}');
  }

  Future<void> getplaceaddress() async {
    final position = await Geolocator.getCurrentPosition();
    double lat = position.latitude;
    double lng = position.longitude;

    String latstring = lat.toString();
    String lngstring = lng.toString();

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latstring,$lngstring&key=AIzaSyD5vuURyC4MjKvGeCrVbBI7T6MZGQMntGc';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print('____________________________________');
    print('Current location: ${position.latitude}, ${position.longitude}');

    if (response.statusCode == 200) {
      String compoundCode =
          jsonDecode(response.body)['plus_code']['compound_code'];
      print(compoundCode);
      String userlo = compoundCode.substring(9);

      setState(() {
        userlocation = userlo;
        print('구글맵api돈');
      });
    } else {
      throw Exception('Failed to load compound code');
    }
  }

  void printUserToken() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String? idToken = await user.getIdToken();
      Map<String, dynamic> decodedToken = JwtDecoder.decode(idToken!);
      useremail = decodedToken['email'];
      userepictureurl = decodedToken['picture'];
      username = decodedToken['name'];

      setState(() {});
      print('파이어베이스 돈나가요');
    } else {
      print('No user is signed in.');
    }
  }

  Future<void> _initUserDetails() async {
    printUserToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'add your additional data',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // 둥근 정도를 조절하려면 숫자를 조정하세요
                    color: Colors.grey.shade200, // 원하는 배경색을 설정하세요
                  ),
                  width: 1000,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'location : \n$userlocation',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: useridController,
                  hintText: 'email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: userpasswordController,
                  hintText: 'Password',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: userageController,
                  hintText: 'age',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: userschooleController,
                  hintText: 'School Name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            role = 'ROLE_STUDENT';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: role == 'ROLE_STUDENT'
                              ? Colors.blue
                              : Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'student',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 30),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            role = 'ROLE_TEACHER';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: role == 'ROLE_TEACHER'
                              ? Colors.blue
                              : Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'teacher',
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    submitData();
                  },
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.grey[500], fontSize: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    final userage = userageController.text;
    final username = userageController.text;
    final userid = useridController.text;

    final userpassword = userpasswordController.text;
    final userschool = userschooleController.text;

    final body = {
      "email": userid,
      "password": userpassword,
      "authority": role,
      "name": username,
      "country": userlocation,
      "age": userage,
      "school": userschool,
    };
    const url = 'http://52.79.242.2:8080/auth/signup';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json; charset=utf-8',
    });

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const LoginPage()));
  }
}
