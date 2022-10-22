import 'package:ambulance_app_v1/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'config/light_theme.dart';

void main() {
  runApp(const AmbulanceApp());
}

class AmbulanceApp extends StatelessWidget {
  const AmbulanceApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PCS',
      debugShowCheckedModeBanner: false,
      theme: myLightTheme,
      home: const Splash(),
    );
  }
}
