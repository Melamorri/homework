import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/location.dart';
import 'location_repository.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key,}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late var locations = <MarkedLocation>[];
  final _locationsRepo = LocationsRepository();

  @override
  initState() {
    super.initState();
    _locationsRepo.initDB().whenComplete(() {
      setState(() {
        locations = _locationsRepo.getLocations();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved locations'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(locations[index].name),
            subtitle: Text('${locations[index].latLng.latitude}, ${locations[index].latLng.longitude}'),
          trailing: IconButton(
              icon: const Icon(Icons.delete,),
              onPressed: () {
                _locationsRepo.deleteLocation(locations[index]);
                setState(() {
                 locations = _locationsRepo.getLocations();
                });
              }),
          );
        },),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Navigator.pushNamed(context, 'map')) as MarkedLocation;
          locations.add(result);
          setState(() {});
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}