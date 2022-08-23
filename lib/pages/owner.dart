import 'package:flutter/material.dart';
import 'package:wherebus/tools/get_user_json_model.dart';

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
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 36),
                  child: Text(
                    widget.data.document.fname!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 36),
                  child: TextButton(onPressed: () {}, child: const Text('Sign out')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
