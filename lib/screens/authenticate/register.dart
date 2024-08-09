import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';

import '/services/auth.dart';
import '/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String password = '';

  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: const Icon(Icons.person),
              label: const Text('Sign In'))
        ],
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Register'),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: textDecoration.copyWith(hintText: 'Email'),
                    onChanged: (value) => email = value,
                    validator: (value) => value!.isEmpty ? 'Enter email' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: textDecoration.copyWith(hintText: 'Password'),
                    onChanged: (value) => password = value,
                    validator: (value) => value!.length < 6
                        ? 'Password muat be 6+ characters long'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _auth.registerWithEmailAndPassword(email, password);
                        }
                        Navigator.of(context)
                            .pushReplacementNamed(Home.routeName);
                      },
                      child: const Text('Register'))
                ],
              ))),
    );
  }
}
