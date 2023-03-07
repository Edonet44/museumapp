import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Exitapp extends StatefulWidget {
  const Exitapp({Key? key}) : super(key: key);

  @override
  State<Exitapp> createState() => _ExitappState();
}

class _ExitappState extends State<Exitapp> {
  @override
  Widget build(BuildContext context) {
    return Container(child: closeapp());
  }

  closeapp() {
    if (Platform.isAndroid) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      exit(0);
    }
  }
}
