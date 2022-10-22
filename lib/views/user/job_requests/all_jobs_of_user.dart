import 'package:ambulance_app_v1/models/job_reqs.dart';
import 'package:ambulance_app_v1/services/firebase_service.dart';
import 'package:ambulance_app_v1/views/live_location_tracking_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllJobRequests extends StatefulWidget {
  const AllJobRequests({Key? key}) : super(key: key);

  @override
  State<AllJobRequests> createState() => _AllJobRequestsState();
}

class _AllJobRequestsState extends State<AllJobRequests> {
  @override
  Widget build(BuildContext context) {
    final FirebaseService _services = FirebaseService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Requests"),
      ),
      body: StreamBuilder<QuerySnapshot<JobRequest>>(
        stream: _services.jobRequestsCollection(),
        builder: (context, AsyncSnapshot<QuerySnapshot<JobRequest>> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading..."),
            );
          }

          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          }

          if (snapshot.hasData) {
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
          }

          return const Center(
            child: CircularProgressIndicator(),
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
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LiveTracking(
                    job: job,
                  ))),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.caseType!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(DateFormat('d/M/y')
                  .format(DateTime.parse(job.dateOn!))
                  .toString()),
              Text(
                job.status!,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
