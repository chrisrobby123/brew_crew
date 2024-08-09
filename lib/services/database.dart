import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Database with ChangeNotifier {
  String uid;

  Database([this.uid = ' ']);

  CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  //  Firestore.instance
  // .collection("brews")
  // .document(uid)
  // .get()
  // .then((DocumentSnapshot snapshot) {
  //   User user = User.fromSnapshot(snapshot);
  //   // use the user object here
  // });

  // final QuerySnapshot? brewSnapShot = FirebaseFirestore.instance
  //     .collection('brews')
  //     .snapshots() as QuerySnapshot;

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'name ': name,
      'strength': strength,
      'sugars': sugars,
    });
  }

  // create a function to return it in my custom brew model

  // Stream collectionStream =
  //     FirebaseFirestore.instance.collection('brews').snapshots();
  // Stream documentStream =
  //     FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

  // List<Brew> _brewFromFirebase(QuerySnapshot snapshot) {
  //   // print(snapshot.docs);

  //   return snapshot.d.docs.map((doc) {
  //     return Brew(
  //       name: doc['name'] ?? '',
  //       strength: doc['strength'] ?? '',
  //       sugars: doc['sugars'] ?? '0',
  //     );
  //   }).toList();
  // }

  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }

  // var stream = FirebaseFirestore.instance.collection('brews').startAtDocument('')
  // final DocumentReference docRef =
  //     FirebaseFirestore.instance.collection('brews').doc('uid');
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapShots);
  }

  //final List<QueryDocumentSnapshot> documents = brewCollection.snapshots();

  UserData _userDataFromSnapShots(DocumentSnapshot<dynamic> snapshot) {
    // Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    //  print(data);

    return UserData(
      id: uid,
      name: snapshot.data()!["name"].cast<String>(),
      strength: snapshot.data()!['strength'],
      sugars: snapshot.data()!['sugars'],
    );
  }

  //userdate from snapshot
  // UserData _userDa

  Stream<UserData> get userDate {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapShots);
  }

//   Stream<QuerySnapshot> snapshots = FirebaseFirestore.instance.collection('brews').snapshots();
// Database.listen((snapshot) {
//   snapshot.doc.forEach((doc) {
//     User user = User.fromSnapshot(doc);
//     // use the user object here
//        return UserData(
//       id: uid,
//       name: snapshot['name'],
//       strength: snapshot['strength'],
//       sugars: snapshot['sugars'],
//     );
//   });
// });

// }
//List<Brew>

// Stream<UserData> get userData {
//   return brewCollection.document(uid).snapshots().map(_userDataFromSnapShots);
// }
}
