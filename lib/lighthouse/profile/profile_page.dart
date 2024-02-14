import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lighthouse/data.dart';
import 'package:lighthouse/lighthouse/HomeScreen/appbar.dart';
import 'package:lighthouse/login/auth.dart';
import 'package:lighthouse/login/google_loginpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoding = true;
  List items = [];
  String id = '';

  Map<String, dynamic> userData = {};
  String username = '';
  int userage = 0;
  String userschool = '';
  String userscountry = '';

  @override
  void initState() {
    super.initState();

    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar('profile'),
        body: Visibility(
          visible: isLoding,
          replacement: RefreshIndicator(
              onRefresh: fetchTodo,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sectionName
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {
                                    editname('Name');
                                  },
                                  icon: const Icon(Icons.settings))
                              //edit button
                            ],
                          ),
                          Text(userData['name'] ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'email',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey[200],
                                  ))
                            ],
                          ),
                          Text(userData['email'] ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sectionName
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'age',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {
                                    editage('age');
                                  },
                                  icon: const Icon(Icons.settings))
                              //edit button
                            ],
                          ),
                          Text(userData['age'].toString() ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sectionName
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'school',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {
                                    editschool('school');
                                  },
                                  icon: const Icon(Icons.settings))
                              //edit button
                            ],
                          ),
                          Text(userData['school'] ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sectionName
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'country',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {
                                    editcountry('country');
                                  },
                                  icon: const Icon(Icons.settings))
                              //edit button
                            ],
                          ),
                          Text(userData['country'] ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sectionName
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'role',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey[200],
                                  ))
                              //edit button
                            ],
                          ),
                          Text(userData['role'] ?? ''),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //sectionName
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Level',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey[200],
                                  ))
                              //edit button
                            ],
                          ),
                          Text(userData['level'].toString() ?? ''),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          deleteAccount();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const googleLoginPage()));
                        },
                        child: const Text('account delete')),
                  ],
                ),
              )),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }

  Future<void> editage(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $field',
          style: const TextStyle(color: Colors.black),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.black)),
          onChanged: (value) => {newValue = value},
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () async {
                int newint = int.parse(newValue);
                String? accesstoken = await getToken();
                const url = 'http://52.79.242.2:8080/users/add/info';
                final uri = Uri.parse(url);
                final body = {
                  "age": newint,
                  "name": newValue,
                  "school": userschool,
                  "country": userscountry,
                };
                final response = await http.post(
                  uri,
                  body: jsonEncode(body),
                  headers: {
                    'Content-Type': 'application/json; charset=utf-8',
                    'Authorization': 'Bearer $accesstoken'
                  },
                );
                if (response.statusCode == 200) {
                  showSuccessMessage('Correct');
                } else {
                  showErrorMessage('wrong');
                }

                Navigator.of(context).pop(newValue);
              },
              child: const Text(
                'save',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }

  Future<void> editname(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $field',
          style: const TextStyle(color: Colors.black),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.black)),
          onChanged: (value) => {newValue = value},
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () async {
                String? accesstoken = await getToken();
                const url = 'http://52.79.242.2:8080/users/add/info';
                final uri = Uri.parse(url);
                final body = {
                  "name": newValue,
                  "age": userage,
                  "school": userschool,
                  "country": userscountry,
                };
                final response = await http.post(
                  uri,
                  body: jsonEncode(body),
                  headers: {
                    'Content-Type': 'application/json; charset=utf-8',
                    'Authorization': 'Bearer $accesstoken'
                  },
                );
                if (response.statusCode == 200) {
                  showSuccessMessage('Correct');
                } else {
                  showErrorMessage('wrong');
                }

                Navigator.of(context).pop(newValue);
              },
              child: const Text(
                'save',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }

  Future<void> editschool(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $field',
          style: const TextStyle(color: Colors.black),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.black)),
          onChanged: (value) => {newValue = value},
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () async {
                String? accesstoken = await getToken();
                const url = 'http://52.79.242.2:8080/users/add/info';
                final uri = Uri.parse(url);
                final body = {
                  "school": newValue,
                  "age": userage,
                  "name": newValue,
                  "country": userscountry,
                };
                final response = await http.post(
                  uri,
                  body: jsonEncode(body),
                  headers: {
                    'Content-Type': 'application/json; charset=utf-8',
                    'Authorization': 'Bearer $accesstoken'
                  },
                );
                if (response.statusCode == 200) {
                  showSuccessMessage('Correct');
                } else {
                  showErrorMessage('wrong');
                }

                Navigator.of(context).pop(newValue);
              },
              child: const Text(
                'save',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }

  Future<void> editcountry(String field) async {
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $field',
          style: const TextStyle(color: Colors.black),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.black)),
          onChanged: (value) => {newValue = value},
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () async {
                String? accesstoken = await getToken();
                const url = 'http://52.79.242.2:8080/users/add/info';
                final uri = Uri.parse(url);
                final body = {
                  "country": newValue,
                  "age": userage,
                  "name": newValue,
                  "school": userschool,
                };
                final response = await http.post(
                  uri,
                  body: jsonEncode(body),
                  headers: {
                    'Content-Type': 'application/json; charset=utf-8',
                    'Authorization': 'Bearer $accesstoken'
                  },
                );
                if (response.statusCode == 200) {
                  showSuccessMessage('Correct');
                } else {
                  showErrorMessage('wrong');
                }

                Navigator.of(context).pop(newValue);
              },
              child: const Text(
                'save',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> deleteAccount() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();

        const url = 'http://52.79.242.2:8080/users/delete/info';
        final uri = Uri.parse(url);
        String? accesstoken = await getToken();

        final response = await http.delete(uri, headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accesstoken'
        });
        if (response.statusCode == 200) {
          showSuccessMessage('Deletion sucess');
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const googleLoginPage()));
        } else {
          showErrorMessage('Deletion failed');
        }

        print('계정 정보가 성공적으로 삭제되었습니다.');
      } else {
        print('현재 로그인된 사용자가 없습니다.');
      }
    } catch (e) {
      print('계정 정보 삭제 중 오류가 발생했습니다: $e');
    }
  }

  Future<void> fetchTodo() async {
    const url = 'http://52.79.242.2:8080/users/my/info';
    final uri = Uri.parse(url);
    String? accesstoken = await getToken();
    print(accesstoken);

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $accesstoken'
    });
    if (response.statusCode == 200) {
      final json =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      Map<String, dynamic> userDataa = json;
      userData = userDataa;
      print(userData);
      setState(() {
        isLoding = false;
        userData = userDataa;
        username = userData['name'];
        userage = userData['age'];
        userschool = userData['school'];
        userscountry = userData['country'];
      });
    }
  }
}
