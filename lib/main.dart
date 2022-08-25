import 'package:flutter/material.dart';
import 'package:wherebus/pages/passenger_home.dart';
import 'package:wherebus/pages/sign_in.dart';
import 'package:wherebus/pages/sign_up.dart';
import 'package:wherebus/ui_tools/PassengerNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhereBus',
      home: const SignIn(title: 'SignIn'),
      routes: <String, WidgetBuilder>{
        '/SignUp': (BuildContext context) => const SignUp(title: 'SignUp'),
        '/SignIn': (BuildContext context) => const SignIn(title: 'SignIn'),
      },
    );
  }
}
