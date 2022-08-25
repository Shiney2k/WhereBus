import 'package:flutter/material.dart';
import 'package:wherebus/tools/get_user_json_model.dart';

import '../ui_tools/PassengerNavBar.dart';

class passenger_home extends StatefulWidget {
  const passenger_home({Key? key, required this.data}) : super(key: key);
  final GetUserJsonModel data;

  @override
  State<passenger_home> createState() => _passenger_State();
}

class _passenger_State extends State<passenger_home> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: PassengerNavBar(widget.data),
        appBar: AppBar(
          title: Text('WhereBus'),
          //centerTitle: true,
          backgroundColor: Color.fromARGB(186, 6, 147, 172),
          //automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView());
  }
}
