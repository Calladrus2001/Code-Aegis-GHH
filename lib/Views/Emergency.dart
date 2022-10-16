import 'package:code_margerita/Services/Geolocation.dart';
import 'package:code_margerita/Services/SendSMS.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  bool gotLocation = false;
  late Position _pos;

  Future<Position> getLocation() async {
    Position pos = await YourLocation().determinePosition();
    return pos;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            child: Chip(
              backgroundColor: Colors.white,
              elevation: 4.0,
              label: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.red),
                  const SizedBox(width: 8),
                  const Text(
                    "Emergency mode",
                    style: TextStyle(
                        color: Colors.red, letterSpacing: 0.4, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
                child: Column(
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Hey,",
                    style: TextStyle(
                        letterSpacing: -3,
                        color: Colors.red.shade800,
                        fontSize: 54,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Be Calm",
                    style: TextStyle(
                        letterSpacing: -6,
                        color: Colors.red.shade800,
                        fontSize: 96,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Chip(
                  elevation: 4.0,
                  backgroundColor: Colors.white,
                  label: Text(
                      "Help will be on the way as soon as you press the Button.",
                      style: TextStyle(color: Colors.red, fontSize: 13)),
                ),
                const SizedBox(height: 48),
                Center(
                  child: GestureDetector(
                    child: Chip(
                        elevation: 2.0,
                        backgroundColor: Colors.red.shade900,
                        label: const Text(
                          "Send S.O.S",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () async {
                      _pos = await getLocation();
                      var location =
                          "https://www.google.com/maps/dir/?api=1&destination=" +
                              Uri.encodeComponent(
                                  "${_pos.latitude}, ${_pos.longitude}");
                      final body =
                          "\n~~Code:Pride ALERT~~\n\n~~~~SOS ALERT~~~~\n\nSomeone who has registered you as an emergency contact has sent an SOS Signal to you.\n\nlocation: $location";
                      TwilioSMS().sendSMS(body);
                    },
                  ),
                ),
                const SizedBox(height: 48),
                const Image(image: AssetImage("assets/images/sos.png"))
              ],
            )),
          )
        ],
      ),
    );
  }
}
