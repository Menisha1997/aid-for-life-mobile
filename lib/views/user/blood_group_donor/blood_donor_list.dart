import 'package:ambulance_app_v1/models/app_user_model.dart';
import 'package:ambulance_app_v1/models/blood_group_model.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:flutter/material.dart';

import 'blood_donor_info.dart';

class BloodDonorList extends StatefulWidget {
  const BloodDonorList({Key? key, required this.selectedBloodGroup})
      : super(key: key);

  final BloodGroup selectedBloodGroup;

  @override
  State<BloodDonorList> createState() => _BloodDonorListState();
}

class _BloodDonorListState extends State<BloodDonorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedBloodGroup.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 20, 70, 50),
        child: Column(
          children: [
            const Text(
              "Select a Donor",
              style: TextStyle(
                color: Color.fromARGB(255, 6, 97, 6),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: FutureBuilder(
                  future: APIService()
                      .getUsersByBloodGroups(widget.selectedBloodGroup),
                  builder: (context, AsyncSnapshot<List<AppUser>> snapshot) {
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

                    List<AppUser>? _bloodDonorList = snapshot.data;
                    if (_bloodDonorList!.isEmpty) {
                      return const Center(
                        child: Text("Sorry!, No donors found"),
                      );
                    }
                    return ListView.builder(
                        itemCount: _bloodDonorList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DonorInfo(donor: _bloodDonorList[index])))
                            },
                            title: Text(_bloodDonorList[index].fullName!),
                            subtitle: Text(_bloodDonorList[index].gender!),
                            leading: const Icon(Icons.account_circle_outlined),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
