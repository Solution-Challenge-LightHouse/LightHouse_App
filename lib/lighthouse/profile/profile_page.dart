import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/component/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  //all user
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit $field',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Enter new $field',
              hintStyle: const TextStyle(color: Colors.white)),
          onChanged: (value) => {newValue = value},
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () => Navigator.of(context).pop(newValue),
              child: const Text(
                'save',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
    //update in firestore
    if (newValue.trim().isNotEmpty) {
      //only update if there is something
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'profile page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  //profile pic
                  const Icon(
                    Icons.person,
                    size: 72,
                  ),
                  const SizedBox(height: 10),
                  //user email
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 50),
                  //userdetails
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('My Details'),
                  ),
                  //username
                  MyTextBox(
                      sectionName: 'username',
                      text: userData['username'],
                      iconbutton: IconButton(
                          onPressed: () {
                            editField('username');
                          },
                          icon: const Icon(Icons.settings))),
                  // onPressed: () => editField('username')),
                  //bio
                  MyTextBox(
                      sectionName: 'bio',
                      text: userData['bio'],
                      iconbutton: IconButton(
                          onPressed: () {
                            editField('bio');
                          },
                          icon: const Icon(Icons.settings))),
                  const SizedBox(height: 50),

                  //userposts
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text('My Posts'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error.toString()}'),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
