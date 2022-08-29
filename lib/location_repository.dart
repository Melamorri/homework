import 'package:maps/location.dart';
import 'objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

class LocationsRepository {
  late final Store _store;
  late final Box<MarkedLocation> _box;

  List<MarkedLocation> getLocations() => _box.getAll();

  Future initDB() async {
    _store = await openStore();
    _box = _store.box<MarkedLocation>();
  }

  Future addLocation(MarkedLocation location) async {
    await _box.putAsync(location);
  }

  Future deleteLocation(MarkedLocation location) async {
    _box.remove(location.id);
  }
}
