import 'package:flutter/material.dart';
import 'backend/connection.dart';
import 'screens/screen.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const Map<int, Color> colori = {44: Color.fromARGB(146, 83, 55, 46)};

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
      //inserire uno splash screen https://www.youtube.com/watch?v=xZmTxHZ_0AM
      //home: const HomeScreen(),
      home: const ConnectionCheckerDemo(),
    );
  }
}
