import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/location_repository.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location location = Location();
  late GoogleMapController _mapController;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  LatLng? selectedMarker;

  _checkLocationPermission() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        return;
      }
    }
    PermissionStatus locationForAppStatus = await location.hasPermission();
    if (locationForAppStatus == PermissionStatus.denied) {
      await location.requestPermission();
      locationForAppStatus = await location.hasPermission();
      if (locationForAppStatus != PermissionStatus.granted) {
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    final initialMarker = Marker(markerId: const MarkerId('current_position'), infoWindow: const InfoWindow(title: "Current position"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), position: LatLng(locationData.latitude!, locationData.longitude!));
    _mapController.moveCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude!, locationData.longitude!)));
    setState(() {
      markers.add(initialMarker);
    });
  }

  @override
  initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map page"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(50.45, 30.52),
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        markers: markers,
        onTap: _addMarker,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                markers.clear();
              });
            },
            child: const Text("Сброс"),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context, MarkedLocation(selectedMarker!));
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  _onMapCreated(GoogleMapController mapController) async {
    _mapController = mapController;
    _controller.complete(mapController);
  }
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
  void _addMarker(LatLng position) async {
    selectedMarker = position;
    if (markers.isNotEmpty) {
      markers.clear();
      markers.add(Marker(markerId: const MarkerId("new_position"), infoWindow: const InfoWindow(title: "New Position"), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), position: position));
    }
    setState(() {});
  }

}