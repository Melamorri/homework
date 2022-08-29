import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MarkedLocation {
  @Id()
  int id;
  LatLng latLng;
  String name;
  MarkedLocation({
    this.id = 0,
    this.latLng = const LatLng(10.0, 10.0),
    required this.name,}
      );
}