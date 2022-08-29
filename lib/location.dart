import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MarkedLocation {
  @Id()
  int id;
  String name;
  double longitude;
  double latitude;
  MarkedLocation({
    this.id = 0,
    required this.name,
    required this.longitude,
    required this.latitude,
  });
}