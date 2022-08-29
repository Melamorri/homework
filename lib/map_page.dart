import 'dart:async';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/location.dart';
import 'package:maps/location_repository.dart';
import 'package:maps/start_page.dart';

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
  String? name;
  late var locations = <MarkedLocation>[];
  final _locationsRepo = LocationsRepository();

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
    final initialMarker = Marker(
        markerId: const MarkerId('current_position'),
        infoWindow: const InfoWindow(title: "Current position"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        position: LatLng(locationData.latitude!, locationData.longitude!));
    _mapController.moveCamera(CameraUpdate.newLatLng(
        LatLng(locationData.latitude!, locationData.longitude!)));
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
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _showRenameDialog();
              setState(() {});
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
      markers.add(Marker(
          markerId: const MarkerId("new_position"),
          infoWindow: const InfoWindow(title: "New Position"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
          position: position));
    }
    setState(() {});
  }

  Future _showRenameDialog() => showGeneralDialog(
        context: context,
        barrierDismissible: false,
        pageBuilder: (_, __, ___) {
          final nameController = TextEditingController();
          return AlertDialog(
            title: const Text('Location name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  name = nameController.text;
                  final newLocation = MarkedLocation(name: name!, latLng: selectedMarker!);
                  await _locationsRepo.addLocation(newLocation);
                  setState(() {
                    locations = _locationsRepo.getLocations();
                    Navigator.pop(context);
                    Navigator.pop(context, newLocation);
                  });

                },
                child: const Text('Add'),
              )
            ],
          );
        },
      );
}
