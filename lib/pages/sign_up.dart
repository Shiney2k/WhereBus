import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:wherebus/tools/post_user_json_model.dart';

import '../auth/secrets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required String title}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final phoneController = TextEditingController();

  String dropdownValue = 'Passenger';

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    phoneController.dispose();
    super.dispose();
  }

  var url = Uri.parse(MONGODB_URL_BASE + 'action/insertOne');

  Future<PostUserJsonModel> submitNewUser(String fname, String lname,
      String email, String password, String phone, String accType) async {
    // This post method does not work because
    // http.post method parses keys and values to all lowercase letters
    // this confuses the MongoDB Atlas server to not recognize the 'Content-Type' header
    // HttpClientRequest is used instead to fix this issue

    // var response = await http.post(url,
    //     headers: <String, String>{
    //       'content-type': 'application/json',
    //       'api-key': MONGODB_API_KEY
    //     },
    // body: jsonEncode(<String, dynamic>{
    //   'dataSource': 'Cluster0',
    //   'database': 'WhereBus',
    //   'collection': 'users',
    //   'document': {
    //     'fname': fname,
    //     'lname': lname,
    //     'email': email,
    //     'password': password,
    //     'phone': phone,
    //     'acctype': accType
    //   }
    // }));

    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('api-key', MONGODB_API_KEY);
    request.add(utf8.encode(json.encode({
      'dataSource': 'Cluster0',
      'database': 'WhereBus',
      'collection': 'users',
      'document': {
        'fname': fname,
        'lname': lname,
        'email': email,
        'password': password,
        'phone': phone,
        'acctype': accType
      }
    })));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    // var jsonReply = json.decode(reply);
    httpClient.close();

    if (response.statusCode == 201) {
      return postUserJsonModelFromJson(reply);
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
                  Text('Could not create account'),
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
      return postUserJsonModelFromJson('Error');
    }
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
                height: height * 0.10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 36),
                child: Text(
                  "Sign Up",
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
                              labelText: "First name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-z A-Z]{2,}\s?[a-z A-Z]{2,}?'?-?[a-z A-Z]{2,}?\s?[a-z A-Z]{1,}?")
                                      .hasMatch(value)) {
                                return "Please enter valid name";
                              } else {
                                return null;
                              }
                            },
                            controller: firstNameController,
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
                              labelText: "Last name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-z A-Z]{2,}\s?[a-z A-Z]{2,}?'?-?[a-z A-Z]{2,}?\s?[a-z A-Z]{1,}?")
                                      .hasMatch(value)) {
                                return "Please enter valid name";
                              } else {
                                return null;
                              }
                            },
                            controller: lastNameController,
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
                              labelText: "Email",
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')
                                      .hasMatch(value)) {
                                return "Please enter valid email";
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                          )))),
              Center(
                  child: SizedBox(
                      width: 300,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter valid password";
                              } else {
                                return null;
                              }
                            },
                            controller: passwordController1,
                          )))),
              Center(
                  child: SizedBox(
                      width: 300,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Repeat password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter valid password";
                              } else {
                                return null;
                              }
                            },
                            controller: passwordController2,
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
                              labelText: "Phone",
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
                            controller: phoneController,
                          )))),
              Center(
                child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Account type",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 83, 83, 83),
                            ),
                          ),
                          DropdownButton(
                            value: dropdownValue,
                            items: <String>['Passenger', 'Owner']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
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
      ),
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
                        if (passwordController1.text ==
                            passwordController2.text) {
                          PostUserJsonModel data = await submitNewUser(
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              passwordController1.text,
                              phoneController.text,
                              dropdownValue);

                          if (data.insertedId != 'Error') {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Account created successfully'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text(
                                            'You can now sign in to the app using this account'),
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
                        } else {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Password incorrect'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                          'Password and repeat password do not match.'),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'Please enter repeat password again'),
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
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Text("Create account")),
          )
        ],
      ),
    );
  }
}
