import 'package:brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String? _currentName;
  int? _currentStrength;
  String? _currentSugar;

  final List<String> sugars = ['0', '1', '2', '3', '4'];
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('brews').snapshots();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
      stream: Database(user.uid).userData,
      builder: ((context, snapshot) {
        final uses = snapshot.data;
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text('Update your settings'),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: uses!.name,
                      decoration: textDecoration.copyWith(hintText: 'Title'),
                      onChanged: ((value) {
                        setState(() {
                          value = _currentName.toString();
                        });
                      })),
                  const SizedBox(height: 10),
                  DropdownButtonFormField(
                      decoration: textDecoration,
                      value: _currentSugar ?? uses.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugar'),
                        );
                      }).toList(),
                      onChanged: ((value) {
                        setState(() {
                          value = _currentSugar;
                        });
                      })),
                  const SizedBox(height: 20),
                  Slider(
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor:
                        Colors.brown[_currentStrength ?? uses.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? uses.strength],
                    value: (_currentStrength ?? uses.strength).toDouble(),
                    onChanged: ((value) => setState(() {
                          _currentStrength = value.round();
                        })),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        print(_currentName);
                        print(_currentStrength);
                        print(_currentSugar);
                      },
                      child: const Text('Update')),
                ],
              ),
            ),
          );
        } else {
          return const Loading();
        }
      }),
    );
  }
}
