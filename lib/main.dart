import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import './screens/wrapper.dart';
import './services/auth.dart';
import './models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  final Auth _auth = Auth();
  final Users _user = Users('');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Users(_user.uid),
      child: StreamBuilder<Users>(builder: ((context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.brown),
          home: snapshot.hasData ? Home() : const Authenticate(),
          routes: {
            Home.routeName: (context) => Home(),
            SignIn.routeName: (context) => SignIn(),
            //   SignIn.routeName:(context) => SignIn(toggleView: )
          },
        );
        // if (snapshot.hasData) {
        //   return MaterialApp(
        //     title: 'Brew',
        //     theme: ThemeData(
        //       primarySwatch: Colors.brown,
        //     ),
        //     //initialRoute: Authenticate.routeName,
        //     home: const Wrapper(),

        //   );
        // } else if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const CircularProgressIndicator.adaptive();
        // } else {
        //   return const Authenticate();
        // }
      })),
    );
  }
}
