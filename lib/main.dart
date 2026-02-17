import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/components/fruit_catcher_game.dart';  // ✅ Path sudah benar
import 'game/managers/audio_manager.dart';

void main() async {
  // ==========================================
  // Inisialisasi Flutter binding
  // ==========================================
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize audio
  await AudioManager().initialize();
  
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
  late FruitCatcherGame game;
  final ValueNotifier<int> counter = ValueNotifier<int>(0);

 @override
  void initState() {
    super.initState();
    game = FruitCatcherGame();  
  }

  @override
  void dispose() {
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ==========================================
          // LAYER 1: GameWidget (Area game Flame)
          // ==========================================
          GameWidget(game: game),

          // ==========================================
          // LAYER 2: Score (kiri atas)
          // ==========================================
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

          // ==========================================
          // LAYER 3: Tombol Musik & SFX (kanan atas)
          // ==========================================
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                // Tombol Musik - SUDAH UPDATE
                IconButton(
                  icon: const Icon(Icons.music_note, color: Colors.black),
                  onPressed: () {
                    AudioManager().toggleMusic();
                  },
                ),
                
                // Tombol SFX - SUDAH UPDATE
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {
                    AudioManager().toggleSfx();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}