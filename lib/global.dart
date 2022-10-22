library globals;

import 'models/app_user_model.dart';

AppUser currentUser = AppUser();
String google_api_key = "AIzaSyBR9fEY6efY1bl6aIdzjA4_r9iswUU_9p4";

List<String> caseTypeList = [
  "Emergency",
  "Ordinary",
  "Accident",
  "Death",
];

List<String> caseStatus = [
  "Picked up",
  "Accepted",
  "Pending",
  "Rejected",
];
