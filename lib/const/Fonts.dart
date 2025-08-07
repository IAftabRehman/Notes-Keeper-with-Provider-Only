import 'package:flutter/material.dart';

class AppFont{
  static const arimo = 'Arimo';
  static const roboto = 'Roboto';


  static final TextStyle appBarText = TextStyle (
    fontFamily: roboto,
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Colors.white
  );

  static final TextStyle noteTitle = TextStyle(
    fontFamily: arimo,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  static final TextStyle noteDescription = TextStyle(
    fontFamily: arimo,
    fontSize: 17,
    color: Colors.white
  );

  static final TextStyle openNoteTitle = TextStyle(
    fontFamily: arimo,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle openNoteDescription = TextStyle(
    fontFamily: arimo,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}