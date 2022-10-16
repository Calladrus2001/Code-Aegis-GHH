import 'package:code_margerita/Utils/constants.dart';
import 'package:code_margerita/Views/Auth.dart';
import 'package:code_margerita/Views/Chatbot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final box = GetStorage();
  late bool? hasSecret;
  late String? secret;
  String _input = "";

  @override
  void initState() {
    box.write("dummy", false);
    hasSecret = box.read("hasSecret");
    secret = box.read("secret");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: hasSecret != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Image(image: AssetImage("assets/images/intro.png")),
                    Center(
                      child: Text(
                          "Answer this Easy Question to get a 15% Discount!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: clr1,
                              fontSize: 24,
                              fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(height: 32),
                    Center(
                      child: Text(
                          "Q792. What is the first day in the Gregorian Calender?",
                          style: TextStyle(
                              color: clr1,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                    ),
                    Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter the Answer',
                        ),
                        onChanged: (value) {
                          _input = value;
                        },
                      ),
                    ),
                    SizedBox(height: 32),
                    GestureDetector(
                      child: Chip(
                        label: Text("Submit",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: clr1,
                        elevation: 4.0,
                      ),
                      onTap: () {
                        if (_input == secret) {
                          Get.to(() => AuthScreen());
                        } else {
                          box.write("dummy", true);
                          Get.to(() => Chatbot());
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 120),
                  Center(
                    child: Text("Shh! This is our Secret",
                        style: TextStyle(
                            color: clr1,
                            fontSize: 32,
                            fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(height: 64),
                  Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Enter your Secret Number',
                      ),
                      onChanged: (value) {
                        _input = value;
                      },
                    ),
                  ),
                  SizedBox(height: 64),
                  GestureDetector(
                    child: Chip(
                      label:
                          Text("Submit", style: TextStyle(color: Colors.white)),
                      backgroundColor: clr1,
                      elevation: 4.0,
                    ),
                    onTap: () {
                      box.write("hasSecret", true);
                      box.write("secret", _input);
                      Get.to(() => AuthScreen());
                    },
                  ),
                  SizedBox(height: 24),
                  Text(
                    "This cannot be changed once set, you would need to enter this number for each App session to verify your identity.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
    );
  }
}
