import 'package:flutter/material.dart';

ElevatedButton customButton(String buttonLabel, VoidCallback onPressed) {
  return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey.shade800,
          fixedSize: const Size(170, 70),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text(buttonLabel));
}
