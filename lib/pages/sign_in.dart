import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wherebus/pages/owner_home.dart';
import 'package:wherebus/pages/passenger_home.dart';
import 'package:wherebus/tools/get_user_json_model.dart';

import '../auth/secrets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required String title}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  String name = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  var url = Uri.parse(MONGODB_URL_BASE + 'action/findOne');

  Future<GetUserJsonModel> getUser(String email) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.postUrl(url);
    request.headers.set('Content-Type', 'application/json');
    request.headers.set('api-key', MONGODB_API_KEY);
    request.add(utf8.encode(json.encode({
      'dataSource': 'Cluster0',
      'database': 'WhereBus',
      'collection': 'users',
      'filter': {"email": email}
    })));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    // print(reply);
    // var jsonReply = json.decode(reply);
    httpClient.close();

    if (response.statusCode == 200) {
      return getUserJsonModelFromJson(reply);
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
                  Text('Could not sign in'),
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
      return getUserJsonModelFromJson(json.encode(<String, dynamic>{
        'document': {'_id': 'Error'}
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 36),
                      child: Text(
                        "Welcome to",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 36),
                      child: Text(
                        "WhereBus",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/wherebus.png"))),
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
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: "Enter your email",
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
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter password',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter valid password";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: passwordController,
                                )))),
                    SizedBox(
                      height: height * 0.10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 40),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/SignUp');
                                },
                                child: const Text("Create account"))),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                final navigator = Navigator.of(context);
                                if (formKey.currentState!.validate()) {
                                  GetUserJsonModel data =
                                      await getUser(emailController.text);
                                  if (data.document.id != 'Error' ||
                                      data.document.id != 'Empty') {
                                    if (data.document.email ==
                                        emailController.text) {
                                      if (data.document.password ==
                                          passwordController.text) {
                                        emailController.text = '';
                                        passwordController.text = '';
                                        if (data.document.acctype ==
                                            'Passenger') {
                                          var passengerHome =
                                              passenger_home(data: data);
                                          navigator.push(MaterialPageRoute(
                                              builder: (context) =>
                                                  passengerHome));
                                        } else if (data.document.acctype ==
                                            'Owner') {
                                          var ownerPage = Owner(data: data);
                                          navigator.push(MaterialPageRoute(
                                              builder: (context) => ownerPage));
                                        }
                                      } else {
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Incorrect password'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: const <Widget>[
                                                    Text(
                                                        'Please enter correct password'),
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
                                    } else {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                                const Text('Incorrect email'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(
                                                      'Please enter correct email'),
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
                                  } else if (data.document.id == 'Empty') {
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title:
                                              const Text('Account not found'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                Text(
                                                    'Please enter valid email'),
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
                              },
                              child: const Text("Sign in")),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Forgot your password?",
                          style: TextStyle(fontSize: 12),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "recover password",
                              style: TextStyle(fontSize: 12),
                            ))
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}
