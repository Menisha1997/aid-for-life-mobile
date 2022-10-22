import 'dart:async';

import 'package:ambulance_app_v1/global.dart' as global;
import 'package:ambulance_app_v1/models/ambulance_hospital_model.dart';
import 'package:ambulance_app_v1/models/job_reqs.dart';
import 'package:ambulance_app_v1/services/firebase_service.dart';
import 'package:ambulance_app_v1/widgets/custom_button_widget.dart';
import 'package:ambulance_app_v1/widgets/custom_text_form_field_widget.dart';
import 'package:ambulance_app_v1/widgets/progress_HUD.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MakeJobRequest extends StatefulWidget {
  const MakeJobRequest({
    Key? key,
    required this.ambulanceHospital,
  }) : super(key: key);
  final AmbulanceHospital ambulanceHospital;

  @override
  State<MakeJobRequest> createState() => _MakeJobRequestState();
}

class _MakeJobRequestState extends State<MakeJobRequest> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  LatLng _currentPosition = const LatLng(7.419243752048063, 81.82351458912254);
  final Set<Marker> _markers = {};

  final Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> markers = {};

  String currentAddress = "";
  late BitmapDescriptor hospitalIcon;
  late BitmapDescriptor ambulanceIcon;

  bool _isAPIcall = false;

  final _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();
  final _notes = TextEditingController();
  final _phone = TextEditingController();

  String _caseType = "Emergency";
  double? _destinationLat;
  double? _destinationLng;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isAPIcall,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Make a Request"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: _username,
                      label: 'Name',
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      }),
                  CustomTextFormField(
                      controller: _phone,
                      label: 'Phone',
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter First Name';
                        }
                        return null;
                      }),
                  CustomTextFormField(
                      controller: _notes,
                      label: 'Notes',
                      type: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter First Name';
                        }
                        return null;
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            value: _caseType,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: global.caseTypeList.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _caseType = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  locationMapWidget()
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          Row(
            children: [
              Expanded(
                child: CustomMegaButton(
                  color: Colors.green,
                  labelColor: Colors.white,
                  onPressed: () => saveJobRequest(),
                  label: 'Save',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    //checking whether the service is enabled or not
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {}

    //checking whether the permission is enabled or not
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        currentAddress = 'Location permissions are denied';
      }
    }

    // // if the permission denied forever
    if (permission == LocationPermission.deniedForever) {
      currentAddress =
          "Location permissions are permanently denied, we cannot request permissions.";
    }
    // await getCurrentLocation();
  }

  getCurrentLocation() async {
    await getLocationPermission();
    _geolocatorPlatform.getCurrentPosition().then((Position position) async {
      _currentPosition = LatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  addMarker(LatLng position) {
    setState(
      () {
        _markers.clear();
        _destinationLng = position.longitude;
        _destinationLat = position.latitude;
        _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            draggable: false,
            markerId: const MarkerId("My Location"),
            position: position,

            icon: BitmapDescriptor.defaultMarker,
            // onDragEnd: ((newPosition) {
            //   print(newPosition.latitude);
            //   print(newPosition.longitude);
            // }),
          ),
        );
      },
    );
  }

  locationMapWidget() {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 300,
                child: GoogleMap(
                  // ignore: prefer_collection_literals
                  gestureRecognizers: Set()
                    ..add(Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer())),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 12.0,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    if (!_mapController.isCompleted) {
                      _mapController.complete(controller);
                    }
                    addMarker(_currentPosition);
                  },
                  onTap: (position) async {
                    addMarker(position);
                  },
                  markers: _markers,
                ),
              ),
            ),
            Positioned(
              right: 60,
              bottom: 10,
              child: CustomButton(
                onPressed: () => getCurrentLocation(),
                lable: 'Use My Location',
              ),
            ),
          ],
        ),
        // Text(_productAddress!.toUpperCase()),
        Text("$_destinationLat, $_destinationLng"),
      ],
    );
  }

  message(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  saveJobRequest() async {
    if (_formKey.currentState!.validate()) {
      JobRequest data = JobRequest();
      data.phone = _phone.text.trim();
      data.dateOn = DateTime.now().toIso8601String();
      data.caseType = _caseType;
      data.notes = _notes.text.trim();
      data.ambulanceId = widget.ambulanceHospital.id;
      data.lat = _destinationLat.toString();
      data.lng = _destinationLng.toString();
      data.requestUserId = global.currentUser.id;
      data.status = "Pending";
      data.userName = _username.text.trim();

      setState(() {
        _isAPIcall = true;
      });
      await FirebaseService().addJobReqs(data: data.toJson()).then((value) {
        setState(() {
          message("Saved Successfully");
          _isAPIcall = false;
        });
      });
    } else {
      message("Please fill the form");
    }
  }
}
