import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:highlight_text/highlight_text.dart';

final box2 = GetStorage();
List<String> codewords = box2.read("codewords");
Color clr1 = Colors.deepOrangeAccent;

final Map<String, HighlightedWord> highlights = {
  codewords[0]: HighlightedWord(
    onTap: () {},
    textStyle: const TextStyle(
      fontSize: 26,
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
    ),
  ),
  codewords[1]: HighlightedWord(
    onTap: () {},
    textStyle: const TextStyle(
      fontSize: 26,
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
    ),
  ),
  codewords[2]: HighlightedWord(
    onTap: () {},
    textStyle: const TextStyle(
      fontSize: 26,
      color: Colors.orange,
      fontWeight: FontWeight.bold,
    ),
  ),
  codewords[3]: HighlightedWord(
    onTap: () {},
    textStyle: const TextStyle(
      fontSize: 26,
      color: Colors.orange,
      fontWeight: FontWeight.bold,
    ),
  ),
  codewords[4]: HighlightedWord(
    onTap: () {},
    textStyle: const TextStyle(
      fontSize: 26,
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
    ),
  ),
};

List<String> codebase = [
  "pineapple",
  "large",
  "pepperoni",
  "garlic",
  "pizzas",
  "cheese",
  "olives",
  "pickles",
  "paneer",
  "extra",
  "small",
  "medium",
  "farmhouse",
  "extravaganza",
  "crust",
  "pan",
  "sauce",
  "egg",
  "macaroni",
  "tomato",
  "sausage",
  "mozzarella",
  "barbeque",
  "bagels",
  "ham",
  "beef",
  "onion",
  "bacon",
  "salmon",
  "meatballs",
  "classic",
  "artichoke",
  "mushroom",
  "chicken",
  "thin",
  "coke",
  "chocolate",
  "strawberry",
  "tacos",
  "calzone"
];
