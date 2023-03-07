import 'package:flutter/material.dart';
import 'package:museumapp/screens/qcode.dart';
import '../backend/connection.dart';
import '../theme/theme.dart';
import '../utils/app_color.dart';
import '../utils/app_large_text.dart';
import '../utils/app_text.dart';
import '../utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  /* @override
  void initState() {
    ConnectionCheckerDemo();
    super.initState();
  } */

  //array di immagini
  List images = ["1.png", "2.png", "3.png"];
  List txtTitle = [
    "Benvenuto in Museum",
    "Scegli l opera...",
    "Utilizza il QrCode..."
  ];
  List textDesc = [
    "Scorri a destra",
    "Scorri ancora a destra",
    "Ascolta l autore"
  ];
  List textSubtitle = [
    "Scegli il percorso e guarda",
    "Il Qrcode e' in basso",
    "chiedi consigli a fine mostra"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //padding: EdgeInsets.only(bottom: 60),
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: ((_, index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    opacity: 0.9,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${images[index]}"))),
            width: double.maxFinite,
            height: double.maxFinite,
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                children: [
                  Column(
                    //asse trasversale
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: txtTitle[index].toString()),
                      AppText(
                        text: textSubtitle[index].toString(),
                        size: 25,
                      ),
                      //SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: AppText(
                          text: textDesc[index].toString(),
                          color: AppColors.textColor1,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),

                      InkWell(child: ResponsiveButton(context))
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    ));
  }
}

//create button
ResponsiveButton(context) {
  return Container(
    child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => qCode()));
        },
        child: Text("Clicca qui")),
  );
}
