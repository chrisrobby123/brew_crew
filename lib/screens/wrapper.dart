import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home/home.dart';
import './authenticate/authenticate.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic user = Provider.of<Users?>(context);
    print(user);

    if (user == null) {
      print('authenticate');
      return const Authenticate();
    } else {
      print('home');
      return Home();
    }
  }
}
