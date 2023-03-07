// To parse this JSON data, do
//
//     final itinerario = itinerarioFromJson(jsonString);

import 'package:http/http.dart' as http;
import 'dart:convert';

// To parse this JSON data, do
//
//     final qrCode = qrCodeFromJson(jsonString);

import 'dart:convert';

import 'package:museumapp/screens/qcode.dart';

List<QrCode> qrCodeFromJson(String str) =>
    List<QrCode>.from(json.decode(str).map((x) => QrCode.fromJson(x)));

String qrCodeToJson(List<QrCode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QrCode {
  QrCode({
    this.nome,
    this.codice,
    this.qcode,
    this.descrizione_autori,
    this.museo_fk,
    this.titolo,
    this.descrizione_opere,
    this.anno,
    this.imgLink,
    this.videoLink,
  });

  String? nome;
  String? codice;
  String? qcode;
  String? descrizione_autori;
  String? museo_fk;
  String? titolo;
  String? descrizione_opere;
  String? anno;
  String? imgLink;
  String? videoLink;

  //il toString passa i valori altrimenti la classe passa solo l'istanza
  @override
  String toString() =>
      "$nome,$codice,$qcode,$descrizione_autori,$museo_fk,$titolo,$descrizione_opere,$anno,$imgLink,$videoLink";

  factory QrCode.fromJson(Map<String, dynamic> json) => QrCode(
        nome: json == null ? 'vuoto' : json["nome"]!,
        codice: json == null ? 'vuoto' : json["codice"]!,
        qcode: json == null ? 'vuoto' : json["qcode"]!,
        descrizione_autori:
            json == null ? 'vuoto' : json["descrizione_autori"]!,
        museo_fk: json == null ? 'vuoto' : json["museo_fk"]!,
        titolo: json == null ? 'vuoto' : json["titolo"]!,
        descrizione_opere: json == null ? 'vuoto' : json["descrizione_opere"]!,
        anno: json == null ? 'vuoto' : json["anno"]!,
        imgLink: json == null ? 'vuoto' : json["img_link"]!,
        videoLink: json == null ? 'vuoto' : json["video_link"]!,
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "codice": codice,
        "qcode": qcode,
        "descrizione_autori": descrizione_autori,
        "museo_fk": museo_fk,
        "titolo": titolo,
        "descrizione_opere": descrizione_opere,
        "anno": anno,
        "img_link": imgLink,
        "video_link": videoLink,
      };

  String urlQrcode =
      "https://edoardotest.000webhostapp.com/qcodeConnection.php";

//funzione che recupera i dati dal database

  Future<List<QrCode>> fetchQrCode() async {
    /*
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;
  */
    var response = await http.get(Uri.parse(
        urlQrcode)); /*, headers: {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8',
    "Authorization": "Bearer $value"
  });*/
    if (response.statusCode == 200) {
      //List<QrCode> list = qrCodeFromJson(response.body);

      var rb = response.body;

      // store json data into list
      var lista = json.decode(rb) as List;

      // iterate over the list and map each object in list to Img by calling Img.fromJson
      List<QrCode> Qcode = lista.map((i) => QrCode.fromJson(i)).toList();

      print(Qcode.runtimeType); //returns List<Qcode>
      print(Qcode[0].runtimeType); //returns Qcode

      return Qcode;
    } else {
      throw ("Non ho accesso al codice QrCode");
    }
  }
}
