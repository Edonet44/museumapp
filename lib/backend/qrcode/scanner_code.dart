import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class barcodeReader extends StatefulWidget {
  _barcodeReaderState createState() => _barcodeReaderState();
}

// ignore: camel_case_types
class _barcodeReaderState extends State<barcodeReader> {
  String _title = 'Barcode Scanner';
  String _result = 'Click Scan button for start to scan';
  String _scanButtonLabel = 'Scan';
  String _scanResult = '(Empty result)';
  String _errorMessage = 'Unknown error';
  List? data;
  Future<String>? resultBarcode;
  Future<String>? resultIlac;

  Future _scanCode() async {
    try {
      _scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#5fa693', 'Cancella', true, ScanMode.QR);
      setState(() {
        _result = _scanResult;
      });
    } catch (e) {
      _errorMessage = '$_errorMessage $e';

      setState(() {
        _result = _errorMessage;
      });
    }
  }

  Future<String> loadJsonData(int index, snapshot) async {
    var jsonText = await rootBundle.loadString('assets/csvjson_2son.json');
    var mydata = JsonDecoder().convert(snapshot.data.toString());
    setState(() => data = json.decode(jsonText));
    mydata[index]['BARKOD'] = resultBarcode;
    mydata[index]['ILAC ADI'] = resultIlac;
    if (resultBarcode == _result) {
      return resultIlac!;
    }
    throw '';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData(0, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xFF3EB16F),
        title: Text("Barcode Scanner"),
        centerTitle: true,titleTextStyle:TextStyle(fontSize: 44, fontFamily: "Angel") ,
       /*  textTheme: TextTheme(
          headline6: TextStyle(fontSize: 44, fontFamily: "Angel"),
        ) */
      ),
      body: Center(
        child: Text('$_result'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.scanner),
        label: Text('$_scanButtonLabel'),
        onPressed: _scanCode,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
