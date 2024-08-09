import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:brew_crew/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import './database.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //final u.User _user = u.User('');

  Users? _userFromFirebase(User? user) {
    return user != null ? Users(user.uid) : null;
  }

  // Stream<Users?> get users {
  //   return _auth.authStateChanges().map(_userFromFirebase);
  // }

  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //sign in anon
  // Future sigInAnon() async {
  //   try {
  //     final result = await _auth.signInAnonymously();
  //     dynamic user = result.user;
  //     return _userFromFirebase(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = result.user;
    print(user);
    return _userFromFirebase(user);
  }

  // register users

  Future registerWithEmailAndPassword(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password)
        //.then((value) async
        //  { var u = value.user;
        //  return u;
        //  },
        ;

    final users = result.user;

    await Database(users!.uid).updateUserData('0', 'new crew member', 100);
    return _userFromFirebase(users);
  }

  // sign out

  Future<void> signOutt() async {
    await _auth.signOut();
    //  users =  await await _auth.currentUser!;

    // try {
    //   await _auth.signOut();
    //    = (await await _auth.currentUser!) as String;
    //   print('Sign in Successfully');

    //   // return result;
    // } catch (e) {
    //   print(e.toString());
    // }
  }
}
