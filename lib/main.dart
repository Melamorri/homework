import 'package:database/primarySwatch.dart';
import 'package:flutter/material.dart';

import 'notes_main_page.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey.shade900,
        primarySwatch: primarySwatchColor
      ),
      home: const NotesMainPage(),
    );
  }
}
