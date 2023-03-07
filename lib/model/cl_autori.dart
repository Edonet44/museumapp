//creazione della classe Autori
import 'package:museumapp/model/cl_opere.dart';

/**
 * Tipo : Crud
 * Link: uno a molti con tabella Opere
 * Metodi:
 */

class Autori {
  Autori(
      {required this.uid,
      required this.codice,
      required this.nome,
      required this.descrizione,
      this.img});

  int uid;
  List<Opere> codice;
  String nome;
  String descrizione;
  String? img;

  factory Autori.fromJson(Map<String, dynamic> json) => Autori(
        uid: json == null ? 0 : json["uid"],
        nome: json == null ? 'vuoto' : json["nome"],
        descrizione: json == null ? 'vuoto' : json["descrizione"],
        img: json == null ? 'vuoto' : json["img"]!,
        codice:
            //in questo caso si crea la uno a molti ovvero:
            /*
        la fuzione from crea una lista di tutti gli oggetti che vengono recuperati dalla funzione Opere.fromJson(x) 
        presente nella classe Opere mappata tramite il codice : codice_fk ovvero la foregin key della classe Opere
        */
            List<Opere>.from(json["codice_fk"].map((x) => Opere.fromJson(x))),
      );
}
