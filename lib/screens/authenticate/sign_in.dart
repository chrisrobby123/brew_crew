import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/services/auth.dart';

class SignIn extends StatefulWidget {
  var toggleView;
  SignIn([this.toggleView]);
  // SignIn({super.key, [required this.toggleView]});

  static const routeName = 'signin';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Auth _auth = Auth();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text('Register'))
        ],
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign In'),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: textDecoration.copyWith(hintText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: textDecoration.copyWith(hintText: 'Password'),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _auth.signInWithEmailAndPassword(email, password);
                  } on FirebaseException catch (e) {
                    print(e.toString());
                  }
                  Navigator.of(context).pushReplacementNamed(Home.routeName);
                },
                child: const Text('Sign In'),
              ),
            ],
          ))),
    );
  }
}
