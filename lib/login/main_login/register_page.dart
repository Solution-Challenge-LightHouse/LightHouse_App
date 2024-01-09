import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/component/button.dart';
import 'package:flutterlogin/component/text_field.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({required this.onTap, super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final confirmPasswordTextfield = TextEditingController();

    void displaymessage(String message) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(message),
              ));
    }

    //sign user up
    void signUp() async {
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));

      //make sure password match
      if (passwordTextController.text != confirmPasswordTextfield.text) {
        Navigator.pop(context);
        displaymessage("Password dont't match");
        return;
      }
      //try creating the uwer
      try {
        //create the user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailTextController.text,
                password: passwordTextController.text);

        //after creating the user,create a new document in the cloud firestore called Users
        FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.email)
            .set({
          'username': emailTextController.text.split('@')[0], //initial username
          'bio': 'Empty bio..' //initaily empty bio
        });

        if (context.mounted) Navigator.pop(context);
      } on FirebaseException catch (e) {
        Navigator.pop(context);
        displaymessage(e.code);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              const Text('Lets create an account for you'),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true),
              MyTextField(
                  controller: confirmPasswordTextfield,
                  hintText: 'Confirm Password',
                  obscureText: true),
              const SizedBox(
                height: 10,
              ),
              Mybutton(ontap: signUp, text: 'sign up'),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
