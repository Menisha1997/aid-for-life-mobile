import 'package:ambulance_app_v1/models/disease_model.dart';
import 'package:flutter/material.dart';

class DiseaseInfo extends StatelessWidget {
  const DiseaseInfo({Key? key, required this.disease}) : super(key: key);

  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          disease.title!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            disease.title!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(height: 30),
          const Divider(),
          const Text(
            "Discription",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(disease.desc!),
          const SizedBox(height: 30),
          const Divider(),
          const Text(
            "Symptoms",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Text(disease.symptoms!),
          const SizedBox(height: 30),
          const Divider(),
          const Text(
            "First Aid",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(disease.firstAid!),
          const SizedBox(height: 30),
          const Divider(),
        ],
      )),
    );
  }
}
