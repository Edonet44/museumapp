// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

// To parse this JSON data, do
//
//     final qrCode = qrCodeFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

/*old
List<QrCode> qrCodeFromJson(String str) =>
    List<QrCode>.from(json.decode(str).map((x) => QrCode.fromJson(x)));

*/

List<QrCode> qrCodeFromJson(String str) {
  final result = json.decode(str);
  return List<QrCode>.from(result.map((item) => QrCode.fromJson(item)));
}

String qrCodeToJson(List<QrCode> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QrCode {
  String? indice;
  String? qrCode;
  String? name;
  DateTime? data;

  QrCode({
    this.indice,
    this.qrCode,
    this.name,
    this.data,
  });
  factory QrCode.fromJson(Map<String, dynamic> json) => QrCode(
        indice: json["indice"] as String,
        qrCode: json["qr_code"] as String,
        name: json["name"] as String,
        data: DateTime.parse(json["data"]) as DateTime,
      );

  Map<String, dynamic> toJson() => {
        "indice": indice,
        "qr_code": qrCode,
        "name": name,
        "data":
            "${data!.year.toString().padLeft(4, '0')}-${data!.month.toString().padLeft(2, '0')}-${data!.day.toString().padLeft(2, '0')}",
      };

  String urlQrcode = "http://www.biofficinadelleapi.it/qr_code.php";

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
