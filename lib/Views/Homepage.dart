import 'package:code_margerita/Utils/constants.dart';
import 'package:code_margerita/Views/Chatbot.dart';
import 'package:code_margerita/Views/Helpline.dart';
import 'package:code_margerita/Views/VideoCall/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> bodyPages = [
    Helpline(),
    Chatbot(),
    IndexPage(),
  ];
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _index,
          selectedItemColor: clr1,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Helpline"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.robot), label: "Chatbot"),
            BottomNavigationBarItem(
                icon: Icon(Icons.videocam), label: "VideoCall"),
          ],
          onTap: (int index) {
            setState(() {
              _index = index;
            });
          },
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: _index,
              children: bodyPages,
            ),
          ],
        ));
  }
}
