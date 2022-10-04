import 'package:ambulance_app_v1/models/blood_group_model.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/widgets/custom_paint_widget.dart';
import 'package:flutter/material.dart';

import 'blood_donor_list.dart';

class BloodGroupList extends StatefulWidget {
  const BloodGroupList({Key? key}) : super(key: key);

  @override
  _BloodGroupListState createState() => _BloodGroupListState();
}

class _BloodGroupListState extends State<BloodGroupList> {
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
                "Select Your Blood Group",
                style: TextStyle(
                  color: Color.fromARGB(255, 6, 97, 6),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: FutureBuilder(
                    future: APIService().getAllBloodGroups(),
                    builder:
                        (context, AsyncSnapshot<List<BloodGroup>> snapshot) {
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

                      List<BloodGroup>? _bloodGroups = snapshot.data;
                      return ListView.builder(
                          itemCount: _bloodGroups!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BloodDonorList(
                                        selectedBloodGroup:
                                            _bloodGroups[index])))
                              },
                              title: Text(_bloodGroups[index].title!),
                              subtitle: Text(_bloodGroups[index].desc!),
                              leading: const Icon(Icons.bloodtype_outlined),
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
