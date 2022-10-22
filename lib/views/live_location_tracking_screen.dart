import 'dart:async';

import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/models/ambulance_hospital_model.dart';
import 'package:ambulance_app_v1/models/ambulance_status.dart';
import 'package:ambulance_app_v1/models/job_reqs.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ambulance_app_v1/global.dart' as global;

class LiveTracking extends StatefulWidget {
  const LiveTracking({
    Key? key,
    required this.job,
  }) : super(key: key);

  final JobRequest job;

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  late final AmbulanceHospital? ambulanceHospital;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  LatLng _currentPosition = const LatLng(7.419243752048063, 81.82351458912254);

  final Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> markerLocs = {};

  String currentAddress = "";
  late BitmapDescriptor ambulanceIcon;
  late BitmapDescriptor hospitalIcon;
  late BitmapDescriptor userIcon;

  bool isLoaded = false;

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    setMarkerIcon();
    fetchAmbulanceData();
    super.initState();
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  getPolyline(
      _originLatitude, _originLongitude, _destLatitude, _destLongitude) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        global.google_api_key,
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Ambulance Path")]);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  fetchAmbulanceData() async {
    await APIService().getAmbulance(widget.job.ambulanceId!).then((value) {
      setState(() {
        ambulanceHospital = value;
        isLoaded = true;

        addMarker(
            LatLng(double.parse(ambulanceHospital!.latitude!),
                double.parse(ambulanceHospital!.longitude!)),
            "Ambulance Home",
            hospitalIcon);

        addMarker(
            LatLng(
                double.parse(widget.job.lat!), double.parse(widget.job.lng!)),
            widget.job.userName!,
            userIcon);
        // getPolyline(
        //   double.parse(ambulanceHospital!.latitude!),
        //   double.parse(ambulanceHospital!.longitude!),
        //   double.parse(widget.job.lat!),
        //   double.parse(widget.job.lng!),
        // );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Tracking"),
      ),
      body: isLoaded
          ? StreamBuilder<QuerySnapshot<AmbulanceStatus>>(
              stream: FirebaseService()
                  .getAmbulanceStatus(widget.job.ambulanceId.toString()),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<AmbulanceStatus>> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }

                AmbulanceStatus ambulanceStatus =
                    snapshot.data!.docs.first.data();

                addAmbulanceLiveTrackerMarker(
                    ambulanceHospital!, ambulanceStatus);

                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(7.419243752048063, 81.82351458912254),
                        zoom: 12.0,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) async {
                        if (!_mapController.isCompleted) {
                          _mapController.complete(controller);
                        }

                        // addAmbulanceLiveTrackerMarker(ambulanceHospital!, ambulanceStatus);
                      },
                      markers: markerLocs,
                      polylines: Set<Polyline>.of(polylines.values),
                    ));
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.location_searching,
          color: Colors.white,
        ),
        onPressed: () {
          moveToCurrentLocationInMap();
        },
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
  }

  getCurrentLocation() async {
    await getLocationPermission();
    _geolocatorPlatform.getCurrentPosition().then((Position position) async {
      _currentPosition = LatLng(position.latitude, position.longitude);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  addMarker(LatLng postion, String markerId, BitmapDescriptor bitmap) {
    markerLocs.add(
      Marker(
        draggable: false,
        markerId: MarkerId(markerId),
        position: postion,
        infoWindow: InfoWindow(
          title: markerId,
        ),
        icon: bitmap,
      ),
    );
  }

  addAmbulanceLiveTrackerMarker(
      AmbulanceHospital dataModel, AmbulanceStatus ambulanceStatus) {
    markerLocs.add(
      Marker(
        draggable: false,
        markerId: MarkerId(ambulanceStatus.ambulanceId.toString()),
        position: LatLng(double.parse(ambulanceStatus.lat.toString()),
            double.parse(ambulanceStatus.lng.toString())),
        infoWindow: InfoWindow(
            title: dataModel.title,
            snippet: dataModel.type,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(dataModel.type!),
                      content: SizedBox(
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dataModel.title!),
                            Text(dataModel.location!),
                          ],
                        ),
                      ),
                      actions: [
                        OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.cancel_outlined),
                            label: const Text("Close")),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {
                              _makePhoneCall(dataModel.contactNo!);
                            },
                            icon: const Icon(Icons.call),
                            label: const Text("Call")),
                      ],
                    );
                  });
            }),
        icon: dataModel.type == "Ambulance"
            ? ambulanceIcon
            : BitmapDescriptor.defaultMarker,
      ),
    );
    //   },
    // );
  }

  setMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), AppImage.AMBULANCE_ICON)
        .then((d) {
      ambulanceIcon = d;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), AppImage.HOSPITAL_ICON)
        .then((d) {
      hospitalIcon = d;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), AppImage.USER_ICON)
        .then((d) {
      userIcon = d;
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  moveToCurrentLocationInMap() async {
    await getCurrentLocation();

    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_currentPosition.latitude, _currentPosition.longitude),
        14.4746));
  }
}
