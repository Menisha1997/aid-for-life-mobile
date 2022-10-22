import 'package:ambulance_app_v1/models/ambulance_status.dart';
import 'package:ambulance_app_v1/models/job_reqs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
// <-------- Collection Reference Users ---->

  final CollectionReference ambulanceStatus =
      FirebaseFirestore.instance.collection('ambulance_status');
  final CollectionReference jobReqs =
      FirebaseFirestore.instance.collection('job_requests');

  jobRequestsCollection() {
    return jobReqs
        .withConverter<JobRequest>(
          fromFirestore: (snapshot, _) => JobRequest.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        )
        .snapshots();
  }

  Future<void> addJobReqs({Map<String, dynamic>? data}) {
    return jobReqs
        .doc()
        .set(data)
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add: $error"));
  }

  Future<void> updateJobReqs(dynamic data, id) {
    return jobReqs
        .doc(id)
        .update(data)
        .then((value) => print("Updated"))
        .catchError((error) => print("Failed to update: $error"));
  }

  Future<void> addAmbStatus({Map<String, dynamic>? data}) {
    return ambulanceStatus
        .doc()
        .set(data)
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add: $error"));
  }

  Future<void> updateAmbStatus(dynamic data, id) {
    return ambulanceStatus
        .doc(id)
        .update(data)
        .then((value) => print("Updated"))
        .catchError((error) => print("Failed to update: $error"));
  }

  Stream<QuerySnapshot<AmbulanceStatus>> getAmbulanceStatus(ambulanceId) {
    return ambulanceStatus
        .where('ambulanceId', isEqualTo: ambulanceId)
        .withConverter<AmbulanceStatus>(
            fromFirestore: (snapshot, _) =>
                AmbulanceStatus.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson())
        .snapshots();
  }
}
