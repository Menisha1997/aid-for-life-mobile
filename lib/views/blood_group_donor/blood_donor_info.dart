import 'package:ambulance_app_v1/models/app_user_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonorInfo extends StatelessWidget {
  const DonorInfo({Key? key, required this.donor}) : super(key: key);

  final AppUser donor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(donor.fullName!),
      ),
      body: Center(
          child: Column(
        children: [
          Text(donor.fullName!),
          const Divider(),
          Text(donor.dateOfBirth!),
          const Divider(),
          Text(donor.email!),
          const Divider(),
          Text(donor.gender!),
          const Divider(),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                _makePhoneCall(donor.phoneNo!);
              },
              icon: const Icon(Icons.call),
              label: const Text("Call")),
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
