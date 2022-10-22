import 'package:ambulance_app_v1/models/disease_model.dart';
import 'package:flutter/material.dart';

class DiseaseInfo extends StatelessWidget {
  const DiseaseInfo({Key? key, required this.disease}) : super(key: key);

  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(disease.title!),
      ),
      body: Center(
          child: Column(
        children: [
          Text(disease.title!),
          const Divider(),
          Text(disease.desc!),
          const Divider(),
          Text(disease.symptoms!),
          const Divider(),
          Text(disease.firstAid!),
          const Divider(),
        ],
      )),
    );
  }
}
