import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:ambulance_app_v1/views/auth/signup_screen.dart';
import 'package:ambulance_app_v1/views/dashboard/home_page.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

import 'Call_page.dart';
import 'blood_group_list.dart';
import 'firstaid_page.dart';
import 'map_page.dart';

class Firstaid extends StatefulWidget {
  const Firstaid({Key? key}) : super(key: key);

  @override
  _FirstaidState createState() => _FirstaidState();
}

class _FirstaidState extends State<Firstaid> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Call_page(),
    const Call_page(),
    const Firstaid(),
    const BloodGroupList(),
    const Firstaid(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: BackGroundPainter(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 190, 70, 50),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              const Text(
                "Find Your Doner",
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 97, 6),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
