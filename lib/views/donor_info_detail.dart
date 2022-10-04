import 'package:ambulance_app_v1/models/blood_group_model.dart';
import 'package:flutter/material.dart';

class BloodGroupInfo extends StatefulWidget {
  const BloodGroupInfo({Key? key, required this.bloodGroup}) : super(key: key);

  final BloodGroup bloodGroup;

  @override
  State<BloodGroupInfo> createState() => _BloodGroupInfoState();
}

class _BloodGroupInfoState extends State<BloodGroupInfo> {
  late BloodGroup _bloodGroup;

  @override
  void initState() {
    _bloodGroup = widget.bloodGroup;
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
              child: Text(_bloodGroup.title!),
            ),
          )
        ],
      ),
    );
  }
}
