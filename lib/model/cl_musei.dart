import 'package:museumapp/model/cl_opere.dart';

/**
 * Tipo : Crud
 * Link: uno a molti con tabella Opere
 * Metodi:
 */

class Musei {
  Musei(
      {required this.uid,
      required this.nome,
      required this.via,
      required this.citta,
      this.telefono});

  int uid;
  List<Opere> nome;
  String via;
  String citta;
  String? telefono;

  factory Musei.fromJson(Map<String, dynamic> json) => Musei(
      uid: json == null ? 0 : json["uid"],
      nome: List<Opere>.from(json["musei_fk"].map((x) => Opere.fromJson(x))),
      via: json == null ? 'vuoto' : json["via"],
      citta: json == null ? 'vuoto' : json["città"],
      telefono: json == null ? 'vuoto' : json["telefono"]!);
}
