import 'package:ambulance_app_v1/models/blood_group_model.dart';
import 'package:flutter/material.dart';

import '../models/blood_doner_model.dart';

class BloodDonorInfo extends StatefulWidget {
  const BloodDonorInfo({Key? key, required this.bloodDoner}) : super(key: key);

  final BloodDoner bloodDoner;

  @override
  State<BloodDonorInfo> createState() => _BloodDonorInfoState();
}

class _BloodDonorInfoState extends State<BloodDonorInfo> {
  late BloodDoner _bloodDoner;

  @override
  void initState() {
    _bloodDoner = widget.bloodDoner;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: Text(_bloodDoner.name),
            ),
          )
        ],
      ),
    );
  }
}
