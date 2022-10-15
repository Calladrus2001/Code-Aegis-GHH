import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatBubble {
  Future<void> _copyToClipboard(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
    Get.snackbar("Code:Aegis", "Copied!");
  }

  Widget buildBubble(String email, String message) {
    Color clr = Color(0xffF2F4F6);
    Color txtclr = Colors.blueGrey;
    return Align(
        alignment: email == FirebaseAuth.instance.currentUser!.email
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                constraints: BoxConstraints(maxWidth: 220),
                decoration: BoxDecoration(
                    color: clr,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment:
                      email == FirebaseAuth.instance.currentUser!.email
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    email == FirebaseAuth.instance.currentUser!.email
                        ? Text("You",
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepOrangeAccent))
                        : Text("${email}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.deepOrangeAccent)),
                    Text(message,
                        style: TextStyle(color: txtclr, fontSize: 18)),
                  ],
                ),
              ),
              onLongPress: () {
                _copyToClipboard(message);
              },
            ),
            SizedBox(height: 4)
          ],
        ));
  }
}
