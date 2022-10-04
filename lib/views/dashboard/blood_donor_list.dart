import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/const/app_size_const.dart';
import 'package:ambulance_app_v1/models/blood_doner_model.dart';
import 'package:ambulance_app_v1/models/blood_group_model.dart';
import 'package:ambulance_app_v1/views/auth/signup_screen.dart';
import 'package:ambulance_app_v1/views/dashboard/home_page.dart';
import 'package:ambulance_app_v1/views/donor_info_detail.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:flutter/material.dart';

import 'Call_page.dart';
import 'firstaid_page.dart';
import 'map_page.dart';

class BloodDonerList extends StatefulWidget {
  const BloodDonerList({Key? key}) : super(key: key);

  @override
  _BloodDonerListState createState() => _BloodDonerListState();
}

class _BloodDonerListState extends State<BloodDonerList> {
  int _currentIndex = 0;
  final List<BloodDoner> _bloodDoners = [
    BloodDoner(
        name: "Ranjeth", id: 1, blooaGroup: "A+", contectNumber: "0751234567"),
    BloodDoner(
        name: "Kalai", id: 2, blooaGroup: "A1", contectNumber: "0751234567"),
    BloodDoner(
        name: "Kaji", id: 3, blooaGroup: "O+", contectNumber: "0751234567"),
    BloodDoner(
        name: "Jeena", id: 4, blooaGroup: "A-", contectNumber: "0751234567"),
    BloodDoner(
        name: "Kuperan", id: 5, blooaGroup: "A+", contectNumber: "0751234567"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: BackGroundPainter(context),
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 190, 70, 50),
          child: Column(
            children: [
              Text(
                "Find Your Doner",
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 97, 6),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _bloodDoners.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => {},
                        title: Text(_bloodDoners[index].name),
                        subtitle: Text(_bloodDoners[index].blooaGroup),
                        leading: Icon(Icons.bloodtype_outlined),
                      );
                    }),
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
