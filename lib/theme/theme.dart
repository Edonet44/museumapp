import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

/**
 * Temi da utilizzare nell applicazione
 * Ver 1.0
 */
//-------------------------------------------Home---------------------------------------------------
class Stili {
  //rende la classe prtivata
  Stili._();

  static final TextStyle IntestazioneTitolo = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: 'Ubuntu',
  );

  static final TextStyle IntestazioneSottotitolo = const TextStyle(
      color: Color.fromARGB(255, 31, 30, 26),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu');

  static final TextStyle DescrizioneProfiloHome = const TextStyle(
      color: const Color.fromARGB(255, 252, 250, 250),
      fontSize: 18,
      fontWeight: FontWeight.bold,
      height: 1.2,
      fontFamily: 'Ubuntu');

  static final TextStyle IntestazioneTitolo2 = const TextStyle(
      color: Color.fromARGB(255, 224, 227, 14),
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu');

  static final TextStyle IntestazioneTitoloProfilo = const TextStyle(
      color: const Color.fromARGB(255, 224, 227, 14),
      fontSize: 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu');

  static final TextStyle sottoscrizioneProfilo = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: 'Ubuntu');

//--------------------------------------Second page-------------------------------------------

  static final TextStyle sottoscrizioneProfilo2 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: 'Ubuntu');

//----------------------------------------Third Page----------------------------------------

  static final TextStyle IntestazioneSottotitolo3 = const TextStyle(
      color: Color.fromARGB(255, 248, 248, 247),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu');
}
