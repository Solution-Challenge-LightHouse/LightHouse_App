import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';
const storage = FlutterSecureStorage();

void setToken(String token) {
  storage.write(key: ACCESS_TOKEN_KEY, value: token);
}

Future<String?> getToken() async {
  String? token = await storage.read(key: ACCESS_TOKEN_KEY);
  return token;
}
