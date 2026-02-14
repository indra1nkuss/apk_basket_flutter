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

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

  class _GameScreenState extends State<GameScreen> {
  
  final ValueNotifier<int> counter = ValueNotifier(1);

  @override
  void initState() {
    super.initState();
    
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
        children: [
          // ==========================================
          // BAGIAN ATAS: Game Area (Expanded + Stack)
          // ==========================================
          Expanded(
            child: Stack(
              children: [
                // Score di kiri atas
                Positioned(
                  top: 50,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ValueListenableBuilder<int>(
                      valueListenable: counter,
                      builder: (context, score, child) {
                        return Text(
                          'Score: $score',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),

       Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.black),
                  onPressed: () {
                    // Aksi untuk musik
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {
                  }
                  ),
                    ],
                  ),
                ),
              ],
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text("Tambah Score"),
            ),
          ),
          
        ],
      ),
    );
  }
}