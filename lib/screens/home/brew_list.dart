import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';

import '../../models/brew.dart';

class BrewList extends StatefulWidget {
  //const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    //  final brews = Provider.of<List<Brew>>(context);
    // final Brew brew = snapshot.data!.docs.map((DocumentSnapshot document) {
    //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    // });
    Stream<QuerySnapshot> collectionStream =
        FirebaseFirestore.instance.collection('brews').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: collectionStream, //Database().brews,
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.brown[data['strength']],
                    ),
                    title: Text('new solid'),
                    subtitle: Text('Takes ${data['sugars']} sugar(s)'),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}
