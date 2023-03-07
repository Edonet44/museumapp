import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
//import 'package:museumapp/model/qrcode2_model.dart';
import 'package:museumapp/screens/details_page.dart';

import '../../model/qrcode2_model.dart';
import '../../widget/buttonwidget.dart';
//import 'fromqr_todata.dart';

class QR_scanner extends StatefulWidget {
  const QR_scanner({Key? key}) : super(key: key);

  @override
  State<QR_scanner> createState() => _QR_scannerState();
}

class _QR_scannerState extends State<QR_scanner> {
  String qrCode = '';
  List<QrCode>? search_code;
  List<QrCode> QrcodeList = [];
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF313131),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: const Text(
            "Digita su Scanner Qrcode",
            style: const TextStyle(
                fontFamily: "Sofia", fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(qrCode,
              style: const TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 28,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),
          ButtonWidget(
              text: "Scanner Qrcode",
              onClicked: () {
                ScanQrcode();
              },
              color: Colors.red)
        ])));
  }

  Future<void> ScanQrcode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#5fa693', 'Cancella', true, ScanMode.QR);
      final String result = qrCode.replaceAll('https://qarcode.io/', '');

      //QrcodeList = await QrCode().fetchQrCode();

      QrcodeList = await QrCode().fetchQrCode();
//funzione di ricerca nella lista per il valore passato dallo scanner Qr_code
//va riscritta un attimo la funzione di ricerca in questo modo:
/*
Se il valore passato è diverso da nullo--allora prende valore qrcode e chiama dialog e stampa a video l utente
Se il valore passato non esiste nel database---allora stampa a video valore non presente
*/
      /*search_code = test
          .where((element) => (element != null
              ? element.qrCode == result
              : Check_value_qrcode_json())).cast<String>()
          .toList();
          List<Food> foods = FAKE_FOOD.where((food) => 
        food.categoryId==this.category!.id).toList();
*/
//List<QrCode> search_code=QrcodeList.where((element) => (element.qrCode == result).toList();

      search_code = QrcodeList.where((code) => code.qcode == result).toList();

      if (!mounted) return;
      setState(() {
        this.qrCode = qrCode.isEmpty
            ? ''
            : qrCode == '-1'
                ? ''
                : elimina_carattere(qrCode);
      });
    } on PlatformException {
      qrCode = "impossibile scannerizzare";
    }
    Check_value_qrcode_json(search_code);
  }

  elimina_carattere(String code) {
    final String result = code.replaceAll('https://qarcode.io/', '');
    print(result);
    return result;
  }

/*
  
  Future_data_formQrCode() {
    // return FutureBuilder<List<QrCode>>(
    child:
    FutureBuilder(
      future: fetchQrCode(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        /*
Lista che appare dal file qr_code.php
[{"indice":"1","qr_code":"43242jjkfskd","name":"edoardo","data":"2006-03-02"},
{"indice":"2","qr_code":"343dlfdgldkf","name":"gianni","data":"2022-03-02"},
{"indice":"3","qr_code":"ertero6546","name":"nedo","data":"2022-03-12"},
{"indice":"6","qr_code":"Conad_28","name":"mauro","data":"2022-03-22"}] 

        
        in questa parte del codice prima della stampa del listview devo
        pagina di riferimento https://flutterhq.com/questions-and-answers/2206/dart-filter-json-data
        https://stackoverflow.com/questions/69174453/the-operator-isnt-defined-for-the-type-object-try-defining-the-operator
        
        da json a listtitle https://www.youtube.com/watch?v=IHHn03P2zI4

        utilizzo di where su listview builder https://www.youtube.com/watch?v=y-sfrhq8Q_I
        1: filtrare il json solo per la ricerca del valore qr_code
        utilizzare la funzione where e passare il valore del qrcode

        */

        //NB ---> PER RISOLVERE L ERRORE TERRIBILE DISTRUTTIVO GIGANTESCO DI ASSEGNAMENTO CIOE' <----
        // The operator '[]' isn't defined for the type 'QrCode'.Try defining the operator '[]'.
        //BISOGNA AGGIUNGERE  E TRASFOMARE DA
        //builder: (BuildContext context,snapshot)
        //A
        // builder: (BuildContext context, AsyncSnapshot snapshot)

/*
        search_code = snapshot.data!
            .where((element) => element['qr_code'].contains(qrCode))
            .cast<String>()
            .toList();

Spiegazione :
1 creo una seconda lista [search_code] per filtrare il valore da passare al List Title
2 se il valore passato dallo Scanner è diverso da nullo, allora element prende il valore passato
3 altrimenti richiama una funzione che ritorna un booleano che a sua volta richiamerà un oggetto message dialog


        search_code = snapshot.data!
            .where((element) => (element['qr_code'] != null
                ? element['qr_code'].contains(qrCode)
                : Check_value_qrcode_json()))
            .cast<String>()
            .toList();
*/

        search_code = snapshot.data!
            .where((element) => (element['qr_code'] != null
                ? element['qr_code'].contains(qrCode)
                : Check_value_qrcode_json()))
            .cast<String>()
            .toList();

        return ListView.builder(
//viene listato solo e soltanto il dato passato al qrcode
          itemCount: search_code!.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final qr_code_model = snapshot.data![index];
            //se il valore del modello passato
            return ListTile(
              leading: Text(qr_code_model.qrCode),
              title: Text(qr_code_model.name),
              subtitle: Text(qr_code_model.data.toIso8601String()),
            );
          },
        );
      },
      // );
    );
  }
*/
  Check_value_qrcode_json(List<QrCode>? code) async {
    //viene chiamata se ritorna falso il valore
    //e apre un message dialog con un avviso a schermo.
    /*AlertDialog(
        title: const Text('Messaggio'), content: Text("Utente {$search_code}"));*/
    if (code!.isEmpty) {
      print("Utente non presente");
      _showMyDialog();
    } else {
      //se true ovvero il dato è trovato passa i dati alla Details Page
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Details(),
              settings: RouteSettings(arguments: [
                code
              ])));
      //print(await "Utente presente stampa{$code}");
    }

    //per visualizzare i dati fetchdata bisogna iserire
    //una classe Alert dialog con un set state per aggiornamento dei dati.
    // lascio il link da vedere se successivamente si vuole proseguire...
    // https://www.google.com/search?client=firefox-b-d&q=fetch+data+with+alert+dialog+response
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Codice non presente nel database'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Questo messaggio appare perchè non ci sono i dati nel database',
                  style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Text('Prova a scannerizzare un altro QrCode'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Clicca e riprova'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
