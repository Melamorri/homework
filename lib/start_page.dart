import 'package:flutter/material.dart';
import '/location_repository.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final locations = <Location>[];
  final name = '';
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
          title: Text(locations[index].latLng.latitude.toString()),
        );
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Navigator.pushNamed(context, 'map')) as Location;
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
