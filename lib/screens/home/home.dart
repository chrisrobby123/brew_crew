// @dart=2.9

import 'dart:core';

import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database.dart';
import '../authenticate/sign_in.dart';
import '/services/auth.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  // const Home({super.key});
  static const routeName = 'home';

  final Auth _auth = Auth();

  void signOutt() async {
    await _auth.signOutt();
  }

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    void showSettingsSheet() {
      showModalBottomSheet(
          context: context,
          builder: ((context) {
            return Container(
              // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
              child: SettingsForm(),
            );
          }));
    }

    return StreamProvider<QuerySnapshot>(
        initialData: null,
        create: ((context) => Database().brews),
        builder: ((context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.brown[40],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              title: const Text('Brew Crew'),
              elevation: 0,
              actions: [
                TextButton.icon(
                  onPressed: () {
                    // FutureBuilder(
                    //   future: _auth.signOutt(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       return Home();
                    //     } else {
                    //       return const Center(
                    //         child: CircularProgressIndicator.adaptive(),
                    //       );
                    //     }
                    //   },
                    // );
                    _auth.signOutt();
                    Navigator.of(context)
                        .pushReplacementNamed(SignIn.routeName);
                  },
                  icon: const Icon(Icons.person),
                  label: const Text('Sign out'),
                ),
                TextButton.icon(
                    onPressed: () => showSettingsSheet(),
                    icon: const Icon(Icons.settings),
                    label: const Text('Settings'))
              ],
            ),
            body: BrewList(),
          );
        }));

    // StreamProvider<List<Brew>?>.value(
    //   initialData: const [],
    //   catchError: (context, error) {
    //     showDialog(
    //         context: context,
    //         builder: ((context) {
    //           return AlertDialog(
    //             content: Text('Error found'),
    //           );
    //         }));
    //   },
    //   value: Database().brews,
    //   builder: (context, snapshot)
    // =>
  }
}
