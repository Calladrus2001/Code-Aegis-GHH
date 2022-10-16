import 'dart:async';
import 'package:bubble/bubble.dart';
import 'package:code_margerita/Models/PlaceModel.dart';
import 'package:code_margerita/Services/DecodingService.dart';
import 'package:code_margerita/Services/PlacesAPI.dart';
import 'package:code_margerita/Utils/constants.dart';
import 'package:code_margerita/Views/Cart.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Services/Geolocation.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  late DialogFlowtter instance;
  late Position _currLocation;
  late PlaceModel? places;
  final messageController = new TextEditingController();
  bool isVoice = true;
  bool isListening = false;
  bool isComplete = false;
  bool placedOrder = false;
  List<Map> messsages = [];
  String _text = "";
  List<String> codewords = Decoding().getCodewords(codebase);
  late stt.SpeechToText _speech;
  final box = GetStorage();

  Future<void> getInstance() async {
    instance = await DialogFlowtter.fromFile(
        path: "assets/pizza100-358205-90129ad9e974.json",
        sessionId: "fneuy28gfeuw3rfg");
  }

  @override
  void initState() {
    getInstance();
    _speech = stt.SpeechToText();
    box.write("codewords", codewords);
    messsages
        .add({"data": 0, "message": "Hey There! Please place your order."});
    super.initState();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }

  Future<void> getResponse() async {
    DetectIntentResponse response = await instance.detectIntent(
      queryInput: QueryInput(text: TextInput(text: messageController.text)),
    );
    String? textResponse = response.text;
    setState(() {
      messsages.insert(0, {"data": 0, "message": textResponse});
    });
    getResults();
  }

  Future getResults() async {
    Position currLocation = await YourLocation().determinePosition();
    setState(() {
      _currLocation = currLocation;
    });
    places = await NearYouAPI().getResult(_currLocation);
    if (places != null) {
      setState(() {
        setState(() {
          messsages.insert(0, {
            "data": 0,
            "message":
                "${places!.results![0].name}\n\n${places!.results![0].formattedAddress}"
          });
          messsages.insert(0, {
            "data": 0,
            "message":
                "${places!.results![1].name}\n\n${places!.results![1].formattedAddress}"
          });
          messsages.insert(0, {
            "data": 0,
            "message":
                "${places!.results![2].name}\n\n${places!.results![2].formattedAddress}"
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        heroTag: "cart_button",
        backgroundColor: Colors.white,
        child: Icon(Icons.shopping_cart_outlined, color: clr1),
        onPressed: () {
          box.write("order", _text);
          Get.to(() => CartScreen());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 40),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Column(
              children: [
                GestureDetector(
                  child: const Chip(
                    elevation: 4.0,
                    backgroundColor: Colors.white,
                    label: Text("Glossary",
                        style: TextStyle(color: Colors.deepOrangeAccent)),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        isDismissible: false,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return buildSheet();
                        });
                  },
                ),
                Container(
                  child: ListTile(
                    title: Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF2F4F6),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: "Send Message",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none),
                        cursorColor: clr1,
                        onChanged: (val) {
                          if (messageController.text.isEmpty) {
                            setState(() {
                              isVoice = true;
                            });
                          } else {
                            setState(() {
                              isVoice = false;
                            });
                          }
                        },
                      ),
                    ),
                    trailing: isVoice
                        ? isListening
                            ? FloatingActionButton(
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    isListening = false;
                                    isComplete = true;
                                  });
                                },
                                child: const Icon(
                                  Icons.mic,
                                  color: Colors.deepOrangeAccent,
                                ),
                              )
                            : FloatingActionButton(
                                heroTag: "btn1",
                                backgroundColor: Colors.white,
                                child: const Icon(
                                  Icons.mic_none_rounded,
                                  color: Colors.deepOrangeAccent,
                                ),
                                onPressed: () {
                                  setState(() {
                                    messageController.text = "";
                                    _listen();
                                    isListening = true;
                                  });
                                })
                        : GestureDetector(
                            child: Chip(
                              label: Icon(Icons.send_outlined, color: clr1),
                              labelPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              backgroundColor: Colors.white,
                              elevation: 4.0,
                            ),
                            onTap: () {
                              getResponse();
                              setState(() {
                                messsages.insert(0, {
                                  "data": 1,
                                  "message": messageController.text
                                });
                                isVoice = true;
                              });
                              if (placedOrder == false) {
                                _text = messageController.text;
                                placedOrder = true;
                              }
                              messageController.clear();
                            },
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildSheet() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Your randomised codewords:",
                style: const TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            const Divider(
              indent: 40,
              endIndent: 40,
              thickness: 0.5,
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[0],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "Number of Aggressors",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[1],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "Aggressors are armed",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[2],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "Need Medical aid",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[3],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "In pursuit",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Chip(
                            elevation: 2.0,
                            backgroundColor: Colors.white,
                            label: Text(codewords[4],
                                style: const TextStyle(
                                    color: Colors.deepOrangeAccent,
                                    fontWeight: FontWeight.w700))),
                      ),
                    ),
                    const SizedBox(width: 64),
                    const Text(
                      "In close proximity",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 50,
                  width: 50,
                  child: CircleAvatar(
                    backgroundColor: clr1,
                    child: Text("Rei", style: TextStyle(color: Colors.white)),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                borderWidth: data == 0 ? 1 : 0,
                borderColor: clr1,
                radius: Radius.circular(15.0),
                color: data == 0 ? Colors.white : clr1,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: data == 0
                              ? TextStyle(
                                  color: clr1, fontWeight: FontWeight.bold)
                              : TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  child: CircleAvatar(
                    minRadius: 25,
                    child: CircleAvatar(
                      minRadius: 24,
                      backgroundColor: Colors.white,
                      child: Text("You", style: TextStyle(color: clr1)),
                    ),
                    backgroundColor: clr1,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  void _listen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == "done") {
            setState(() {
              isComplete = true;
              isListening = false;
              isVoice = false;
            });
          }
        },
        onError: (val) {},
      );
      if (available) {
        setState(() => isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            messageController.text = _text;
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      _speech.stop();
    }
  }
}
