import 'package:ambulance_app_v1/models/disease_model.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:flutter/material.dart';

import 'disease_info.dart';

class Firstaid extends StatefulWidget {
  const Firstaid({Key? key}) : super(key: key);

  @override
  _FirstaidState createState() => _FirstaidState();
}

class _FirstaidState extends State<Firstaid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: BackGroundPainter(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 190, 70, 50),
          child: Column(
            children: [
              const Text(
                "Emergency First-Aid",
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 97, 6),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: FutureBuilder(
                    future: APIService().getAllDisease(),
                    builder: (context, AsyncSnapshot<List<Disease>> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Sorry No Data"),
                        );
                      }

                      List<Disease>? _diseaseList = snapshot.data;
                      return ListView.builder(
                          itemCount: _diseaseList!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DiseaseInfo(
                                        disease: _diseaseList[index])))
                              },
                              title: Text(_diseaseList[index].title!),
                              subtitle: Text(_diseaseList[index].desc!),
                              leading: const Icon(Icons.emergency),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
