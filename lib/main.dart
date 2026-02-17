import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/components/fruit_catcher_game.dart'; 
import 'game/managers/audio_manager.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Catcher Game',
      debugShowCheckedModeBanner: false,
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

  @override
  void initState() {
    super.initState();
    game = FruitCatcherGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. LAYER GAME (Paling Bawah)
          GameWidget(game: game),
          
          // 2. SCORE OVERLAY (Pojok Kiri Atas)
          Positioned(
            top: 50,
            left: 20,
            child: ValueListenableBuilder(
              valueListenable: game.scoreNotifier,
              builder: (context, value, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Score: $value',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. TOMBOL AUDIO (Pojok Kanan Atas) - INI YANG KEMBALI
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                // Tombol Musik
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      AudioManager().isMusicEnabled 
                          ? Icons.music_note 
                          : Icons.music_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        AudioManager().toggleMusic();
                      });
                    },
                  ),
                ),
                // Tombol SFX
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      AudioManager().isSfxEnabled 
                          ? Icons.volume_up 
                          : Icons.volume_off,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        AudioManager().toggleSfx();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // 4. TULISAN PETUNJUK (Paling Atas, akan hilang saat main)
          ValueListenableBuilder(
            valueListenable: game.isPlayingNotifier,
            builder: (context, isPlaying, child) {
              if (isPlaying) return const SizedBox.shrink(); 
              
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, color: Colors.white, size: 50),
                      SizedBox(height: 10),
                      Text(
                        'TAP UNTUK MULAI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}