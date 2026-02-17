import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../managers/audio_manager.dart';
import './basket.dart';
import './fruit.dart';
import 'dart:math';

// Tambahkan 'TapCallbacks' disini
class FruitCatcherGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  
  // Notifier untuk memberi tahu UI apakah game sudah mulai atau belum
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

  late Basket basket;
  late TimerComponent fruitSpawner; // Simpan referensi timer
  final Random random = Random();

  void incrementScore() {
    scoreNotifier.value++;
    AudioManager().playSfx('collect.mp3');
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await AudioManager().initialize();
    
    basket = Basket();
    add(basket);
    
    // Siapkan Timer tapi JANGAN di-add dulu (biar buah tidak jatuh sebelum klik)
    fruitSpawner = TimerComponent(
      period: 1.0,
      repeat: true,
      onTick: () => spawnFruit(),
    );
  }

  // Fungsi ini dipanggil otomatis oleh Flame saat layar diklik/sentuh
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    
    // Jika game belum mulai...
    if (!isPlayingNotifier.value) {
      startGame();
    }
  }

  void startGame() {
    isPlayingNotifier.value = true;
    
    // 1. Mulai Musik
    AudioManager().playBackgroundMusic();
    
    // 2. Mulai Spawn Buah
    add(fruitSpawner);
  }
  
  void spawnFruit() {
    final fruit = Fruit(
      position: Vector2(
        random.nextDouble() * (size.x - 100) + 50,
        -50,
      ),
    );
    add(fruit);
  }
}