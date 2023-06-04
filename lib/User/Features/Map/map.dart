import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class newMyMap extends StatefulWidget {
  final String map_id;
  newMyMap(this.map_id);
  @override
  _newMyMap createState() => _newMyMap();
}

class _newMyMap extends State<newMyMap> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('locations')
            .doc(widget.map_id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData == ConnectionState.waiting ||
              snapshot.hasData == ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GoogleMap(
              mapType: MapType.normal,
              markers: {
                Marker(
                  position: LatLng(
                    snapshot.data!.get('lat'),
                    snapshot.data!.get('lng'),
                  ),
                  markerId: const MarkerId('name'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta),
                ),
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                    snapshot.data!.get('lat'),
                    snapshot.data!.get('lng'),
                  ),
                  zoom: 14.47),
              onMapCreated: (GoogleMapController controller) async {},
            );
          }
        },
      ),
    );
  }
}
