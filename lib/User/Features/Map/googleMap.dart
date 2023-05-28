import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:take_drug/Common/Authentication/login.dart';
import 'package:take_drug/Common/config/config.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    String? currentUser = takeDrug.auth?.currentUser?.uid.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("google_map".tr().toString()),
        centerTitle: true,
      ),
      body: currentUser != null
          ? currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    // First icon
                    const Positioned(
                      top: 16,
                      left: 16,
                      child: Icon(Icons.search),
                    ),

                    // Second icon
                    const Positioned(
                      top: 16,
                      right: 16,
                      child: Icon(Icons.my_location),
                    ),

                    // Third icon
                    const Positioned(
                      bottom: 1,
                      right: 11,
                      left: 1,
                      top: 1,
                      child: Icon(Icons.layers),
                    ),

                    // GoogleMap widget
                    GoogleMap(
                      markers: Set<Marker>.of(markers),
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: currentLocation!,
                        zoom: 15,
                      ),
                      onMapCreated: (controller) {
                        mapController = controller;
                        _addMarkers();
                      },
                    ),
                  ],
                )
          : Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    takeDrug.whiteOne,
                  ),
                  shadowColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (_) => const loginPage());
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                },
                child: Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "you_need_to_login".tr().toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: takeDrug.BackgroundColor),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: takeDrug.BackgroundColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'saved_locations',
            onPressed: () {
              // TODO: Implement saved locations functionality
            },
            child: const Icon(Icons.bookmark),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'search',
            onPressed: () {
              // TODO: Implement search functionality
            },
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _addMarkers() async {
    // create a GoogleMapController instance
    GoogleMapController? controller = mapController;

    if (controller == null) {
      return;
    }

    // search for nearby hospitals
    List<Placemark> hospitals = await placemarkFromCoordinates(
      currentLocation!.latitude,
      currentLocation!.longitude,
      localeIdentifier: "en",
    );

    // search for nearby pharmacies
    List<Placemark> pharmacies = await placemarkFromCoordinates(
      currentLocation!.latitude,
      currentLocation!.longitude,
      localeIdentifier: "en",
    );

    // add hospital markers
    for (var hospital in hospitals) {
      markers.add(
        Marker(
          markerId: MarkerId(hospital.toString() + hospital.toString()),
          infoWindow: InfoWindow(
            title: hospital.name ?? '',
            snippet: hospital.locality ?? '',
          ),
          // position: LatLng(
          //   hospital.latitude,
          //   hospital.location.longitude,
          // ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );
    }

    // add pharmacy markers
    for (var pharmacy in pharmacies) {
      markers.add(
        Marker(
          markerId: MarkerId(pharmacy.toString() + pharmacy.toString()),
          infoWindow: InfoWindow(
            title: pharmacy.name ?? '',
            snippet: pharmacy.locality ?? '',
          ),
          // position: LatLng(
          //   pharmacy,
          //   pharmacy as double,
          // ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueYellow,
          ),
        ),
      );
    }

    setState(() {});
  }
}
