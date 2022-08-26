import 'package:flutter/material.dart';
import 'package:wherebus/pages/add_new_bus.dart';
import 'package:wherebus/tools/get_user_json_model.dart';
import 'package:wherebus/widgets/bus_item_cards.dart';

import '../ui_tools/OwnerNavBar.dart';

class Owner extends StatefulWidget {
  const Owner({Key? key, required this.data}) : super(key: key);
  final GetUserJsonModel data;

  @override
  State<Owner> createState() => _OwnerState();
}

class _OwnerState extends State<Owner> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: OwnerNavBar(widget.data),
        appBar: AppBar(
          title: Text('WhereBus'),
          //centerTitle: true,
          backgroundColor: Color.fromARGB(186, 6, 147, 172),
          //automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              BusItemCards(
                data: widget.data,
              )
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 28, bottom: 28),
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewBus(
                                ownerEmail: widget.data.document.email!)));
                  },
                  child: const Icon(Icons.add)),
            )
          ],
        ));
  }
}
