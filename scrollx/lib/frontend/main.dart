import 'package:flutter/material.dart';
import 'package:scrollx/frontend/continue_watching.dart';
import 'package:scrollx/frontend/register_contact.dart';

import 'login.dart';

Future<void> main() async {
  runApp(
    MaterialApp(
      title: 'ScrollX',
      initialRoute: '/login',
      routes: {
        '/login' : (context) => Login()
      },
    )
  );
}