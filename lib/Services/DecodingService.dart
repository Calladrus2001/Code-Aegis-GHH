import 'dart:math';

import 'package:code_margerita/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Decoding {
  final box = GetStorage();
  Map<String, String> decode(String base) {
    List<String> coded = base.split(" ");
    Map<String, String> decoded = {};
    List<String> codewords = box.read("codewords");
    print(coded);
    print(codewords);
    for (int i = 1; i < coded.length; i++) {
      for (int j = 0; j < codewords.length; j++) {
        if (coded[i].toLowerCase() == codewords[j]) {
          decoded[codewords[j]] = coded[i - 1];
        }
      }
    }
    return decoded;
  }

  List<String> getCodewords(List<String> codebase) {
    List<String> codewords = [];
    int len = codebase.length;
    for (int i = 0; i < 5; i++) {
      int flag = 0;
      int rand = Random().nextInt(len - 1);
      for (int i = 0; i < codewords.length; i++) {
        if (codewords[i] == codebase[rand]) {
          flag = 1;
        }
      }
      if (flag == 0) {
        codewords.add(codebase[rand]);
      } else {
        i--;
      }
    }
    return codewords;
  }

  Widget getAbuser(Map<String, String> decoded, var num) {
    if (decoded[codewords[0]] != null) {
      box.write("abuser", decoded[0]);
      return Row(
        children: [
          Text("${codewords[0]} :",
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          const SizedBox(width: 8),
          Container(
            width: 50,
            child: TextFormField(
              initialValue: "${decoded[codewords[0]]}",
              style:
                  const TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
              onEditingComplete: () {},
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              onChanged: (val) {
                box.write("abuser", val);
                num = val;
              },
            ),
          )
        ],
      );
    } else {
      return const SizedBox(height: 0);
    }
  }

  Widget getArmedStatus(Map<String, String> decoded, var num) {
    if (decoded[codewords[1]] != null) {
      box.write("armed", "Yes");
      return Row(
        children: [
          Text("${codewords[1]} :",
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          const SizedBox(width: 8),
          Container(
            width: 50,
            child: TextFormField(
              initialValue: "Yes",
              style:
                  const TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              onChanged: (val) {
                box.write("armed", val);
                num = val;
              },
            ),
          )
        ],
      );
    } else
      return const SizedBox(height: 0);
  }

  Widget getMedical(Map<String, String> decoded, var num) {
    if (decoded[codewords[2]] != null) {
      box.write("medical", "Yes");
      return Row(
        children: [
          Text("${codewords[2]} :",
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          const SizedBox(width: 8),
          Container(
            width: 50,
            child: TextFormField(
              initialValue: "Yes",
              style:
                  const TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              onChanged: (val) {
                box.write("medical", val);
                num = val;
              },
            ),
          )
        ],
      );
    } else
      return const SizedBox(height: 0);
  }

  Widget getMinors(Map<String, String> decoded, var num) {
    if (decoded[codewords[3]] != null) {
      box.write("minors", "Yes");
      return Row(
        children: [
          Text("${codewords[3]} :",
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          const SizedBox(width: 8),
          Container(
            width: 50,
            child: TextFormField(
              initialValue: "Yes",
              style:
                  const TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              onChanged: (val) {
                box.write("minors", val);
                num = val;
              },
            ),
          )
        ],
      );
    } else {
      return const SizedBox(height: 0);
    }
  }

  Widget getProximity(Map<String, String> decoded, var num) {
    if (decoded[codewords[4]] != null) {
      box.write("proximity", "Yes");
      return Row(
        children: [
          Text("${codewords[4]} :",
              style: TextStyle(color: Colors.grey, fontSize: 20)),
          const SizedBox(width: 8),
          Container(
            width: 50,
            child: TextFormField(
              initialValue: "Yes",
              style:
                  const TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              onChanged: (val) {
                box.write("proximity", val);
                num = val;
              },
            ),
          )
        ],
      );
    } else {
      return const SizedBox(height: 0);
    }
  }
}
