import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                  "Sign Up",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: height * 0.02,
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
                              labelText: "First name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-z A-Z]{2,}\s[a-z A-Z]{2,}'?-?[a-z A-Z]{2,}\s?[a-z A-Z]{1,}")
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
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Last name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-z A-Z]{2,}\s[a-z A-Z]{2,}'?-?[a-z A-Z]{2,}\s?[a-z A-Z]{1,}")
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
                              horizontal: 8, vertical: 16),
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
                              horizontal: 8, vertical: 16),
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
                              horizontal: 8, vertical: 16),
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
                              horizontal: 8, vertical: 16),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: "Phone",
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$")
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
                          vertical: 16, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Account type",
                            style: TextStyle(
                              fontSize: 14,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
