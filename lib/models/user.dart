import 'package:flutter/cupertino.dart';

class Users with ChangeNotifier {
  final String uid;

  Users(this.uid);
}

class UserData {
  final String id;
  final String sugars;
  final String name;
  final int strength;

  UserData(
      {required this.id,
      required this.name,
      required this.strength,
      required this.sugars});
}
