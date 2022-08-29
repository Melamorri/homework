import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/location_repository.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key, this.name, this.latlng}) : super(key: key);
  final name;
  final latlng;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final locations = <MarkedLocation>[];
  @override
  Widget build(BuildContext context) {
    //var title = ModalRoute.of(context)?.settings.arguments as MarkedLocation?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved locations'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.name));
            //subtitle: Text(widget.latlng.toString()));
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