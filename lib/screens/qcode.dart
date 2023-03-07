import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../backend/qrcode/exit.dart';
import '../backend/qrcode/qr_code_scanner.dart';

//import '../qrcode/backend/qr_code_scanner.dart';

class qCode extends StatefulWidget {
  qCode({Key? key}) : super(key: key);

  @override
  State<qCode> createState() => HomeState();
}

class HomeState extends State<qCode> {
  int index_selected = 0;
  static const routeName = '/';

  //chiamata alla classe per il qrcode

  List<Widget> _opzione_oggetto = <Widget>[QR_scanner(), Exitapp()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Applicazione di Scanner opere",
          style: TextStyle(fontFamily: "Sofia", fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0.0,
      ), */
      body: Center(
        child: _opzione_oggetto.elementAt(index_selected),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF313131),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner), label: 'Scan Qr Code'),
          BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: 'Esci')
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: index_selected,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF5fa693),
        iconSize: 35,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      index_selected = index;
    });
  }
}
