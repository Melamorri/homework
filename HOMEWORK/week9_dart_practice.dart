import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intl Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateFormat _dateFormat;
  late DateFormat _timeFormat;
  String time = '';

  @override
  void initState() {

    Timer myTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      DateTime currentTime = DateTime.now();
      time = "${currentTime.hour}:${currentTime.minute}:${currentTime.second}";
      setState(() {

      });
    });
    super.initState();
    initializeDateFormatting();
    _setLocale('ru');
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intl Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_dateFormat.format(dateTime)),
            Text(time),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }



  void _setLocale(String locale) {
    _dateFormat = DateFormat.yMMMMd(locale);
    _timeFormat = DateFormat.Hms(locale);
  }


  void _refresh() {
    setState(() {});
  }
}