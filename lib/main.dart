import 'package:flutter/material.dart';
import 'package:wherebus/pages/sign_in.dart';
import 'package:wherebus/pages/sign_up.dart';

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
      home: const SignIn(),
      routes: <String, WidgetBuilder> {
      '/SignUp': (BuildContext context) => const SignUp(title: 'SignUp'),
    },
    );
  }
}