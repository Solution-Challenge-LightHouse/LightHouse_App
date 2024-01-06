import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutterlogin/login/main_login/splah_screen.dart';

class GoogleLoginpage extends StatefulWidget {
  const GoogleLoginpage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<GoogleLoginpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LightHouse'),
        centerTitle: true,
        backgroundColor: const Color(0xFF674AEF),
      ),
      body: _user != null ? _userInfo() : _googleSignInButton(),
    );
  }

  Widget _googleSignInButton() {
    return Center(
      child: SizedBox(
        height: 50,
        child: SignInButton(
          Buttons.google,
          text: 'Sign up with Google',
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }

  Widget _userInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        width: 500,
        height: 1000,
        color: const Color(0xFF674AEF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_user!.photoURL!),
                ),
              ),
            ),
            Text(_user!.email!),
            Text(_user!.displayName ?? ""),
            MaterialButton(
              color: Colors.red,
              onPressed: _auth.signOut,
              child: const Text("Sign out"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 172, 154, 249),
                  minimumSize: const Size(320, 80)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SplashScreen()));
              },
              child: const Text(
                '시작하기',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleGoogleSignIn() {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    } catch (e) {
      print(e);
    }
  }
}
