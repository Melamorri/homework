import 'package:flutter/material.dart';

BoxDecoration customBoxDec = BoxDecoration(
  color: const Color(0xFFf1e0ea),
  border: Border.all(width: 1, color: Colors.blueGrey),
  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
);

InputDecoration textFieldDec = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.blueGrey),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black26),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

BoxDecoration textFieldCont = BoxDecoration(
    color: Color(0xFFf1e0ea),
    borderRadius: BorderRadius.all(Radius.circular(20)));

TextStyle myTextStyle = TextStyle(
    fontSize: 20.0, fontFamily: 'Poppins', fontWeight: FontWeight.bold);

var pic = Image.network(
  'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/TransparentPlaceholder.png/120px-TransparentPlaceholder.png',
  width: 5,
  height: 5,
);
var catPic = Image.network(
    'https://catadoptionteam.org/wp-content/uploads/2019/05/Adopt-Fees-nobkgrd1-768x524.png',
    width: 200,
    height: 200);

var dogPic = Image.network(
  'https://www.woodyspetdeli.com/wp-content/uploads/revslider/hospital/slider-dog-small.png',
  width: 200,
  height: 200,
);
