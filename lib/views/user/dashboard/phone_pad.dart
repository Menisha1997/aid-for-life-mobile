import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:url_launcher/url_launcher.dart';

class PhonePad extends StatefulWidget {
  const PhonePad({Key? key}) : super(key: key);

  @override
  _PhonePadState createState() => _PhonePadState();
}

class _PhonePadState extends State<PhonePad> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 114, 212, 114),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DialPad(
              enableDtmf: true,
              outputMask: "(000) 000-0000",
              backspaceButtonIconColor: const Color.fromARGB(255, 175, 26, 12),
              makeCall: (number) {
                _makePhoneCall(number);
              }),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 50),
              maximumSize: const Size(300, 50),
            ),
            onPressed: () {
              _makePhoneCall("1990");
            },
            child: const Text("Call 1990 (Suwaseriya)"),
          )
        ],
      )),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
