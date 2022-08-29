import 'package:flutter/material.dart';
import 'package:maps/start_page.dart';

import 'map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'start': (_) => const StartPage(),
        'map': (_) => const MapPage(),
      },
      initialRoute: 'start',
    );
  }
}
