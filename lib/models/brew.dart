import 'package:flutter/cupertino.dart';

class Brew with ChangeNotifier {
  final String name;
  final String sugars;
  final int strength;

  Brew({required this.name, required this.strength, required this.sugars});
}
