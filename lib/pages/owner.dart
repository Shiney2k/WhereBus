import 'package:flutter/material.dart';
import 'package:wherebus/pages/add_new_bus.dart';
import 'package:wherebus/tools/get_user_json_model.dart';
import 'package:wherebus/widgets/bus_item_cards.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 36),
                    child: Text(
                      widget.data.document.fname!,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 36),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, child: const Text('Sign out')),
                  )
                ],
              ),
              const SizedBox(height: 16,),
              const BusItemCards()
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewBus(ownerEmail: widget.data.document.email!)));
                  },
                  child: const Icon(
                    Icons.add
                  )),
            )
          ],
        ));
  }
}
