import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:ambulance_app_v1/views/auth/signup_screen.dart';
import 'package:ambulance_app_v1/views/dashboard/home_page.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:url_launcher/url_launcher.dart';

class Call_page extends StatefulWidget {
  const Call_page({Key? key}) : super(key: key);

  @override
  _Call_pageState createState() => _Call_pageState();
}

class _Call_pageState extends State<Call_page> {
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
              minimumSize: const Size(200, 50),
              maximumSize: const Size(200, 50),
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
