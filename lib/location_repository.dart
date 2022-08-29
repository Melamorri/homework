import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkedLocation {
  final LatLng latLng;
  late final String name;
  MarkedLocation(
      this.latLng,
      this.name,
      );
}