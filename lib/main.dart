import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Catcher Game',
      home: GameScreen(), 
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});  // Constructor const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruit Catcher Game'),
      ),
      body: const Center(
        child: Text('Game Screen'),
      ),
    );
  }
}
