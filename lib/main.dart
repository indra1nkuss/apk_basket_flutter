import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/components/fruit_catcher_game.dart';  // Sesuaikan path jika perlu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Catcher Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // ==========================================
  // Inisialisasi game
  // ==========================================
  late FruitCatcherGame game;
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  bool isPaused = false;  // ← TAMBAH: flag untuk pause state

  @override
  void initState() {
    super.initState();
    
    game = FruitCatcherGame(
      onScoreChanged: (newScore) {
        counter.value = newScore;
      },
    );
  }

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ==========================================
          // GAME AREA (Expanded + Stack)
          // ==========================================
          Expanded(
            child: Stack(
              children: [
                // LAYER 1: Flame Game (Background/Board)
                GameWidget(game: game),

                // LAYER 2: Score (Positioned kiri atas)
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

                // LAYER 3: Control (Positioned kanan atas)
                Positioned(
                  top: 50,
                  right: 20,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.music_note, color: Colors.white),
                        onPressed: () {
                          // Toggle musik
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up, color: Colors.white),
                        onPressed: () {
                          // Toggle sound
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // CONTROL BUTTONS (Di bawah game)
          // ==========================================
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol Kiri
                ElevatedButton(
                  onPressed: () {
                    // Aksi gerak kiri
                  },
                  child: const Icon(Icons.arrow_left),
                ),
                
                // Tombol Pause/Play - SUDAH DIPERBAIKI
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isPaused) {
                        game.resumeEngine();
                        isPaused = false;
                      } else {
                        game.pauseEngine();
                        isPaused = true;
                      }
                    });
                  },
                  child: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                ),
                
                // Tombol Kanan
                ElevatedButton(
                  onPressed: () {
                    // Aksi gerak kanan
                  },
                  child: const Icon(Icons.arrow_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}