import 'package:code_margerita/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Helpline extends StatefulWidget {
  const Helpline({Key? key}) : super(key: key);

  @override
  State<Helpline> createState() => _HelplineState();
}

class _HelplineState extends State<Helpline> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.logout, color: clr1),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          setState(() {});
        },
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 32),
                Container(
                  height: 350,
                  width: 350,
                  child: Image(image: AssetImage("assets/images/helpline.jpg")),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
                child: Text(
              "Call",
              style: TextStyle(
                  color: clr1, fontSize: 24, fontWeight: FontWeight.w700),
            )),
            SizedBox(height: 32),
            Container(
              height: 60,
              width: 240,
              decoration: BoxDecoration(
                  color: clr1,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: GestureDetector(
                onLongPress: () {
                  Get.snackbar("Code:Aegis", "Copied!");
                },
                child: Center(
                    child: Text("+12565872797",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white))),
              ),
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
