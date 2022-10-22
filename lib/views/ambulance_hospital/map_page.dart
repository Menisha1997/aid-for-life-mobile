import 'package:ambulance_app_v1/const/app_image_const.dart';
import 'package:ambulance_app_v1/services/api_service.dart';
import 'package:ambulance_app_v1/widgets/progress_HUD.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import '../../models/ambulance_hospital_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  LatLng _currentPosition = const LatLng(7.419243752048063, 81.82351458912254);

  final Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> markers = {};

  String currentAddress = "";
  late BitmapDescriptor hospitalIcon;
  late BitmapDescriptor ambulanceIcon;

  bool _isAPIcall = false;

  @override
  void initState() {
    super.initState();
    setMarkerIcon();
    getAllList();
  }

  setMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(5, 5)), AppImage.AMBULANCE_ICON)
        .then((d) {
      ambulanceIcon = d;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            AppImage.HOSPITAL_ICON)
        .then((d) {
      hospitalIcon = d;
    });
  }

  getAllList() {
    setState(() {
      _isAPIcall = true;
    });
    getAllAmbulance();
    getAllhospitals();
    setState(() {
      _isAPIcall = false;
    });
  }

  getAllAmbulance() {
    APIService().getAllAmbulance().then((value) {
      for (var element in value) {
        addMarker(element);
      }
    });
  }

  getAllhospitals() {
    APIService().getAllHospitals().then((value) {
      for (var element in value) {
        addMarker(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: _isAPIcall,
      child: Scaffold(
        body: SizedBox(
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
              },
              markers: markers,
            )),
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

  addMarker(AmbulanceHospital dataModel) {
    setState(
      () {
        // markers.clear();

        markers.add(
          Marker(
            draggable: false,
            markerId: MarkerId(
                "${dataModel.id}-${dataModel.type}-${dataModel.title}"),
            position: LatLng(double.parse(dataModel.latitude.toString()),
                double.parse(dataModel.longitude.toString())),
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
            icon: dataModel.type == "Ambulance" ? ambulanceIcon : hospitalIcon,
          ),
        );
      },
    );
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
