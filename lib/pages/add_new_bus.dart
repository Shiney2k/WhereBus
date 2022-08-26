import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wherebus/tools/post_bus_json_model.dart';

import '../auth/secrets.dart';

class AddNewBus extends StatefulWidget {
  const AddNewBus({Key? key, required this.ownerEmail}) : super(key: key);
  final String ownerEmail;

  @override
  State<AddNewBus> createState() => _AddNewBusState();
}

class _AddNewBusState extends State<AddNewBus> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

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

  var url = Uri.parse('${mongodburlbase}action/insertOne');

  Future<PostBusJsonModel> submitNewBus(
      String owner,
      String busRegNo,
      String busNumberOfSeats,
      String busDriverContact,
      String busType,
      String bookable) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('api-key', mongodbapikey);
    request.add(utf8.encode(json.encode({
      'dataSource': 'Cluster0',
      'database': 'WhereBus',
      'collection': 'buses',
      'document': {
        'owner': owner,
        'busRegNo': busRegNo,
        'busNumberOfSeats': busNumberOfSeats,
        'busDriverContact': busDriverContact,
        'busType': busType,
        'bookable': bookable
      }
    })));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    // var jsonReply = json.decode(reply);
    httpClient.close();

    if (response.statusCode == 201) {
      return postBusJsonModelFromJson(reply);
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error ${response.statusCode}'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Could not submit data'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Please try again later'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return postBusJsonModelFromJson('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
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
      )),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 40),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 40),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (formKey.currentState!.validate()) {
                          PostBusJsonModel data = await submitNewBus(
                              widget.ownerEmail,
                              busRegNoController.text,
                              busNumberOfSeatsController.text,
                              busDriverContactController.text,
                              busType,
                              bookable);

                          if (data.insertedId != 'Error') {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Saved successfully'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('New bus saved successfully'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: const Text('Save'))),
        ],
      ),
    );
  }
}
