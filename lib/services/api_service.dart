import 'dart:convert';

import 'package:ambulance_app_v1/models/ambulance_hospital_model.dart';
import 'package:ambulance_app_v1/models/blood_group_model.dart';
import 'package:ambulance_app_v1/models/disease_model.dart';
import 'package:http/http.dart' as http;

import '../models/app_user_model.dart';

class APIService {
  static const baseUrl = "http://192.168.8.100:80/api";

  Future<AppUser?> login(Map<String, String> body) async {
    String url = "$baseUrl/AppUserLogin";
    Uri uri = Uri.parse(url);

    final response = await http.post(uri, body: body);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return AppUser.fromJson(
        json.decode(response.body),
      );
    }
    if (response.statusCode == 201) {
      return null;
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<AppUser> signup(AppUser requestModel) async {
    String url = "$baseUrl/AppUserSignup";
    Uri uri = Uri.parse(url);

    Map<String, String?> data = requestModel.toJson();

    final response = await http.post(uri, body: data);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return AppUser.fromJson(
        json.decode(response.body),
      );
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<AppUser> updateUserProfile(AppUser requestModel) async {
    String url = "$baseUrl/AppUser/${requestModel.id}";
    Uri uri = Uri.parse(url);

    Map<String, String?> data = requestModel.toJson();

    final response = await http.patch(uri, body: data);
    if (response.statusCode == 200 || response.statusCode == 400) {
      return AppUser.fromJson(
        json.decode(response.body),
      );
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<List<BloodGroup>> getAllBloodGroups() async {
    String url = "$baseUrl/AllBloodGroups";
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 404) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<BloodGroup>((json) => BloodGroup.fromJson(json))
          .toList();
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<List<AppUser>> getUsersByBloodGroups(
      BloodGroup _selectedBloodGroup) async {
    Map<String, String> requestBody = {
      "bloodGroup": _selectedBloodGroup.title!,
    };

    String url = "$baseUrl/userBloodGroup";
    Uri uri = Uri.parse(url);

    final response = await http.post(uri, body: requestBody);
    if (response.statusCode == 200 || response.statusCode == 404) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<AppUser>((json) => AppUser.fromJson(json)).toList();
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<List<AmbulanceHospital>> getAllHospitals() async {
    String url = "$baseUrl/AllHospitals";
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 404) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<AmbulanceHospital>((json) => AmbulanceHospital.fromJson(json))
          .toList();
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<List<AmbulanceHospital>> getAllAmbulance() async {
    String url = "$baseUrl/AllAmbulances";
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 404) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<AmbulanceHospital>((json) => AmbulanceHospital.fromJson(json))
          .toList();
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<AmbulanceHospital> getAmbulance(int ambulanceId) async {
    String url = "$baseUrl/Ambulance/$ambulanceId";
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 404) {
      return AmbulanceHospital.fromJson(
        json.decode(response.body),
      );
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }

  Future<List<Disease>> getAllDisease() async {
    String url = "$baseUrl/AllDiseases";
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 404) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Disease>((json) => Disease.fromJson(json)).toList();
    } else {
      json.decode(response.body);
      throw Exception('Failed to load data!');
    }
  }
}
