import 'package:flutter/material.dart';

const textDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    // borderSide: BorderSide(color: Colors.white, width: 4),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black45, width: 4),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);
