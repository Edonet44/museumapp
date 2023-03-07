import 'dart:typed_data';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:museumapp/screens/qcode.dart';
import 'package:museumapp/utils/app_large_text.dart';
import 'package:museumapp/utils/app_text.dart';

import '../utils/app_color.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    // qui viene richiamato l accesso al database
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //stringa che recupera i dati dalla classe precendente
    final String Dati_fetch =
        ModalRoute.of(context)!.settings.arguments.toString();
    List<String> items = [];
    //aggiunge nella lista items gli oggetti passati da Dati_fetch
    Dati_fetch.split(',').forEach((item) => items.add(item));
    //elimina la prima parentesi quadra
    final nome =
        items[0].replaceAll(RegExp(r'\s*\[\d+]'), '').replaceAll("[", '');
    //se dovesse essere utile la funzione replaceFirst elimina lo spazio dentro una Stringa
    final codice = items[1].replaceFirst(RegExp(r"\s+"), '');
    final qcode = items[2].replaceFirst(RegExp(r"\s+"), '');
    final descrizione_autori = items[3].replaceFirst(RegExp(r"\s+"), '');
    final museo_fk = items[4].replaceFirst(RegExp(r"\s+"), '');
    final titolo = items[5].replaceFirst(RegExp(r"\s+"), '');
    final descrizione_opere = items[6].replaceFirst(RegExp(r"\s+"), '');
    final anno = items[7].replaceFirst(RegExp(r"\s+"), '');
    final img_link = items[8].replaceFirst(RegExp(r"\s+"), '');
    //elimina ultima parentesi quadra
    final videoLink =
        items[9].replaceAll(RegExp(r'\s+'), '').replaceAll("]", '');

/*
tabelle db

Tab_Artista: Codice,Nome,Descrizione
Tab_Opera: Codice,Valore,Titolo,Descrizione,immagine link,Video link,Anno,Qrcode
Tab_Museo: Nome,Telefono,Via,Civico

come valori verranno passati:

artista --> nome descrizione
opera--> valore titolo descrizione immagine link video link anno
*/
    var item = {'Punteggio': '4.6', 'Prezzo': '300', 'Luogo': '$museo_fk'};
    //var SelectedItem = monuntItems[0];
    return Scaffold(
        drawer: Drawercustom(nome: nome, descrizione: descrizione_autori),
        // backgroundColor: Colors.white10,
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                child: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              //image: AssetImage("assets/images{$img_link}"),
                              image: AssetImage("assets/images/3.png"),
                              fit: BoxFit.fill),
                        )),
                    Positioned.fill(
                        child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7)
                      ], begin: Alignment.center, end: Alignment.bottomCenter)),
                    )),
                    Positioned(
                      bottom: 30,
                      left: 30,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [AppText(text: ""), AppText(text: "")],
                      ),
                    ),
                    AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      iconTheme: const IconThemeData(color: Colors.white),
                      title: const Center(
                        child: Icon(
                          Icons.book_online_rounded,
                          color: Colors.transparent,
                          size: 40,
                        ),
                      ),
                      /* actions: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          //passo i  valori al Drawer
                          child: GestureDetector(
                            onTap: (() => Drawercustom(
                                nome: nome, descrizione: descrizione_autori)),
                            child: const Icon(
                              Icons.pending,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ], */
                    ),
                    //Drawer nb passare i dati
                    //Drawercustom(nome: nome, descrizione: descrizione_autori)
                  ],
                ),
              )),
              Expanded(
                child: Column(
                  children: [
                    DetailRatingTAb(item: item),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Text(
                              titolo,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: Text(
                                '$descrizione_opere',
                                style: const TextStyle(fontSize: 12),
                              )),
                          const Player()
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(children: [
                      Row(
                          //andranno passati i valori
                          children: [
                            // MyHomePage()
                          ] //MyHomePage()]// AudioPlayerPage()],
                          ),
                    ]),
                    DetailsBottomActions()
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (isPlaying) {
                      player.pause();
                    } else {
                      player.play(AssetSource('audio/music.mp3'));
                    }
                  },
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              CircleAvatar(
                radius: 25,
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    player.stop();
                  },
                ),
              ),
              /*   const SizedBox(
                width: 30,
              ),
              CircleAvatar(
                radius: 25,
                child: IconButton(
                  icon: const Icon(Icons.fast_rewind),
                  onPressed: () {
                    player.resume();
                  },
                ),
              ), */
            ],
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     player.play(AssetSource('theme_01.mp3'));
          //   },
          //   child: const Text('Play Audio'),
          // ),
          // ElevatedButton(
          //     onPressed: () {
          //       player.stop();
          //     },
          //     child: const Text('Stop Audio')),
          // ElevatedButton(
          //     onPressed: () {
          //       player.pause();
          //     },
          //     child: const Text('Pause ')),
          /* ElevatedButton(
              onPressed: () {
                player.resume();
              },
              child: const Text('Resume')), */
          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) {
              final position = Duration(seconds: value.toInt());
              player.seek(position);
              player.resume();
            },
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(position.inSeconds)),
                Text(formatTime((duration - position).inSeconds)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailRatingTAb extends StatelessWidget {
  DetailRatingTAb({Key? key, required this.item}) : super(key: key);

  //test iniziale
  // dopo vado di recupero di variabili della classe
  Map<String, String> item = {
    'Rating': '4.6',
    'Price': '300',
    'Museo': 'Fattori'
  };

  var item2 = {'Rating': '4.6', 'Price': '300', 'Museo': 'Fattori'};
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        // ignore: sort_child_properties_last
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //ricordare che il list generate crea gia una lista di conseguenza non bisogna mettere le parentesi quadre in children!!!
          children: List.generate(
              item2.entries.length,
              (index) => Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.2), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.entries.elementAt(index).key,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          item.entries.elementAt(index).value,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  )),
        ));
  }
}

class Drawercustom extends StatelessWidget {
  const Drawercustom({Key? key, required this.nome, required this.descrizione})
      : super(key: key);

  final String nome;
  final String descrizione;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: ListView(
        children: [
          Container(
            //color: const Color.fromARGB(197, 184, 21, 21),
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Container(
                color: Color.fromARGB(197, 232, 179, 47),
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(197, 17, 17, 17)),
                  //accountName: Text("${nome}"),
                  accountName: AppLargeText(text: nome),
                  accountEmail: const Text(""),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/1.png"),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: const Text(
                  "Autore",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                AppText(
                  text: descrizione,
                  color: Colors.black26,
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class DetailsBottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(children: [
          Expanded(
              child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.mainColor,
                  child: InkWell(
                    highlightColor: Colors.white.withOpacity(0.2),
                    splashColor: Colors.white.withOpacity(0.2),
                    onTap: () {
                      //seconda parte con collegamento firebase e autenticazione
                    },
                    child: Container(
                        padding: const EdgeInsets.all(21),
                        child: const Text('Vota l opera',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))),
                  ))),
          Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: AppColors.starColor, width: 2)),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => qCode(),
                        ));
                  },
                  icon: Icon(Icons.qr_code_rounded),
                  iconSize: 30,
                  color: AppColors.mainColor))
        ]));
  }
}
