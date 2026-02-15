import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FruitCatcherGame extends FlameGame {
  // ==========================================
  // Background color (Flame 1.17+ pakai cara ini)
  // ==========================================
  FruitCatcherGame() {
    // Set background color di constructor
    camera.viewfinder.backgroundColor = const Color(0xFF87CEEB);
  }

  // ==========================================
  // Score management
  // ==========================================
  late final int _score = 0;  // Tambah late final
  int get score => _score;
  
  final Function(int)? onScoreChanged;

  // ==========================================
  // Load game
  // ==========================================
  @override
  Future<void> onLoad() async {
    await super.onLoad();
 
  }
}