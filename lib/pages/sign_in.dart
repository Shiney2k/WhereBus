import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  String name = "";

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
                                onPressed: () {},
                                child: const Text("Create account"))),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 40),
                          child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  const snackBar = SnackBar(
                                      content: Text("Signed in successfully"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
                        const Text("Forgot your password?",
                        style: TextStyle(
                          fontSize: 12
                        ),
                        ),
                        TextButton(onPressed: (){}, child: const Text("recover password",
                        style: TextStyle(fontSize: 12),
                        ))
                    ],)
                  ],
                )),
          ),
        ));
  }
}
