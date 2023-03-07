import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../theme/theme.dart';
import '../utils/strings.dart';

class CustomAPPbar extends StatelessWidget {
  //padding
  final double padleft;
  final double padright;
  final double padtop;
  final String? text_Titolo;
  final TextStyle? style_Titolo;
  final String text_sottoTitolo;
  final TextStyle? style_sottoTitolo;
  final Widget? leading;
  final double? opacity;

  const CustomAPPbar(
      {Key? key,
      required this.padleft,
      required this.padright,
      required this.text_Titolo,
      required this.style_Titolo,
      required this.text_sottoTitolo,
      required this.style_sottoTitolo,
      required this.padtop,
      this.leading, this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: padleft, top: padtop, right: padright),
        child: Row(children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: text_Titolo, style: style_Titolo),
            TextSpan(text: "\n"),
            TextSpan(text: text_sottoTitolo, style: style_sottoTitolo),
          ])),
          Spacer(),
          Container(
            child: IconButton(
                padding: EdgeInsets.only(left: 25, top: 10),
                onPressed: () {},
                icon: Icon(size: 40, Icons.menu, color: Colors.black)),
          ),
        ]));
  }
}
