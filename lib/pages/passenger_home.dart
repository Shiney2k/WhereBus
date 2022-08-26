import 'package:flutter/material.dart';
import 'package:wherebus/tools/get_user_json_model.dart';

import '../ui_tools/PassengerNavBar.dart';

class PassengerHome extends StatefulWidget {
  const PassengerHome({Key? key, required this.data}) : super(key: key);
  final GetUserJsonModel data;

  @override
  State<PassengerHome> createState() => PassengerHomeState();
}

class PassengerHomeState extends State<PassengerHome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: PassengerNavBar(data: widget.data),
        appBar: AppBar(
          title: const Text('WhereBus'),
          //centerTitle: true,
          backgroundColor: const Color.fromARGB(186, 6, 147, 172),
          //automaticallyImplyLeading: false,
        ),
        body: const SingleChildScrollView());
  }
}
