import 'package:ambulance_app_v1/models/job_reqs.dart';
import 'package:ambulance_app_v1/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllJobsDriver extends StatefulWidget {
  const AllJobsDriver({Key? key}) : super(key: key);

  @override
  State<AllJobsDriver> createState() => _AllJobsDriverState();
}

class _AllJobsDriverState extends State<AllJobsDriver> {
  @override
  Widget build(BuildContext context) {
    final FirebaseService _services = FirebaseService();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<JobRequest>>(
        stream: _services.jobRequestsCollection(),
        builder: (context, AsyncSnapshot<QuerySnapshot<JobRequest>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                JobRequest job = snapshot.data!.docs[index].data();

                return JobContainer(
                    job: job, services: _services, context: context);
              }),
            ),
          );
        },
      ),
    );
  }
}

class JobContainer extends StatelessWidget {
  const JobContainer({
    Key? key,
    required this.job,
    required this.services,
    required this.context,
  }) : super(key: key);

  final JobRequest job;
  final FirebaseService services;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(job.caseType!),
    );
  }
}
