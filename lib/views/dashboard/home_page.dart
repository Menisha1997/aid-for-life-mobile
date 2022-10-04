import 'package:ambulance_app_v1/views/profile/profile_page.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:flutter/material.dart';
import '../disease/firstaid_page.dart';
import 'phone_pad.dart';
import '../blood_group_donor/blood_group_list.dart';
import '../ambulance_hospital/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const MapPage(),
    const PhonePad(),
    const Firstaid(),
    const BloodGroupList(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: BackGroundPainter(context),
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_outlined),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'First aid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype),
            label: 'Blood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 50, 170, 54),
        elevation: 5.0,
        unselectedItemColor: const Color.fromARGB(255, 12, 90, 16),

        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
