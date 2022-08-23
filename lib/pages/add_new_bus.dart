import 'package:flutter/material.dart';

class AddNewBus extends StatefulWidget {
  const AddNewBus({Key? key}) : super(key: key);

  @override
  State<AddNewBus> createState() => _AddNewBusState();
}

class _AddNewBusState extends State<AddNewBus> {
  final formKey = GlobalKey<FormState>();

  final busRegNoController = TextEditingController();
  final busNumberOfSeatsController = TextEditingController();
  final busDriverContactController = TextEditingController();

  String busType = 'Non AC - Normal';
  String bookable = 'Not available';

  @override
  void dispose() {
    busRegNoController.dispose();
    busNumberOfSeatsController.dispose();
    busDriverContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.08,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 36),
              child: Text(
                "Add new bus",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Center(
                child: SizedBox(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Bus registration number",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter valid registration number";
                            } else {
                              return null;
                            }
                          },
                          controller: busRegNoController,
                        )))),
            Center(
                child: SizedBox(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Number of seats",
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter valid number";
                            } else {
                              return null;
                            }
                          },
                          controller: busNumberOfSeatsController,
                        )))),
            Center(
                child: SizedBox(
                    width: 300,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: "Bus driver contact number",
                          ),
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^(\+\d{1,2}\s?)?\(?\d{2}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
                                    .hasMatch(value)) {
                              return "Please enter valid phone number";
                            } else {
                              return null;
                            }
                          },
                          controller: busDriverContactController,
                        )))),
            Center(
              child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bus type",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 83, 83, 83),
                          ),
                        ),
                        DropdownButton(
                          value: busType,
                          items: <String>[
                            'Non AC - Normal',
                            'Non AC - Intercity',
                            'AC',
                            'Expressway'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              busType = newValue!;
                            });
                          },
                        )
                      ],
                    ),
                  )),
            ),
            Center(
              child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Book seats",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 83, 83, 83),
                          ),
                        ),
                        DropdownButton(
                          value: bookable,
                          items: <String>['Not available', 'Available']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              bookable = newValue!;
                            });
                          },
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.04,
            ),
          ],
        ),
      ))),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Save'))),
        ],
      ),
    );
  }
}
