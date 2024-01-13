import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/component/drawer.dart';
import 'package:flutterlogin/component/helper_method.dart';
import 'package:flutterlogin/component/text_field.dart';
import 'package:flutterlogin/component/wall_post.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/appbar.dart';
import 'package:flutterlogin/lighthouse/HomeScreen/drawer.dart';

class CommunityHomePage extends StatefulWidget {
  const CommunityHomePage({super.key});

  @override
  State<CommunityHomePage> createState() => _HomePageState();
}

//user
final currentUser = FirebaseAuth.instance.currentUser!;

//text controller
final textController = TextEditingController();

void signOut() {
  FirebaseAuth.instance.signOut();
}

void postMessage() {
  //only post if there is somthing in the textField
  if (textController.text.isNotEmpty) {
    FirebaseFirestore.instance.collection("User Posts").add({
      'UserEmail': currentUser.email,
      'Message': textController.text,
      'TimeStamp': Timestamp.now(),
      'Likes': [],
    });

    textController.clear();
  }
}

class _HomePageState extends State<CommunityHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: renderAppBar(),
      drawer: drawer(),
      body: Center(
        child: Column(
          children: [
            //the wall
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          message: post['Message'],
                          user: post['UserEmail'],
                          PostId: post.id,
                          likes: List<String>.from(post['Likes'] ?? []),
                          time: formatDate(post['TimeStamp']),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error:${snapshot.error}'),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
              stream: FirebaseFirestore.instance
                  .collection('User Posts')
                  .orderBy('TimeStamp', descending: false)
                  .snapshots(),
            )),
            //post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: textController,
                        hintText: 'Write something on the wall',
                        obscureText: false),
                  ),

                  //post button
                  const IconButton(
                      onPressed: postMessage, icon: Icon(Icons.arrow_circle_up))
                ],
              ),
            ),
            //logeged in as
            Text(
              'Logged in as: ${currentUser.email!}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
