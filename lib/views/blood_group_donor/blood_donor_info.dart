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
        title: Text(
          donor.fullName!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "Full Name",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(donor.fullName!),
          const Divider(),
          const Text(
            "Date Of Birth",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(donor.dateOfBirth!),
          const Divider(),
          const Text(
            "Doner Email",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(donor.email!),
          const Divider(),
          const Text(
            "Donmer Gender",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(donor.gender!),
          const Divider(),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                _makePhoneCall(donor.phoneNo!);
              },
              icon: const Icon(Icons.call_to_action_outlined),
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
