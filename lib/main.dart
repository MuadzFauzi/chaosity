import 'package:flutter/material.dart';
import 'screens/starting_screen.dart';

void main() {
  runApp(const ChaosityGame());
}

class ChaosityGame extends StatelessWidget {
  const ChaosityGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chaosity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Kita kunci font default ke sans-serif tebal untuk getaran minimalis modern
        primarySwatch: Colors.grey,
        fontFamily: 'Yaelah',
      ),
      home: const StartingScreen(),
    );
  }
}