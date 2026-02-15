import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FruitCatcherGame extends FlameGame {
  // ==========================================
  // Background color - Override METHOD (bukan getter)
  // ==========================================
  @override
  Color backgroundColor() => const Color(0xFF87CEEB); // sky blue

  // ==========================================
  // Score management
  // ==========================================
  int _score = 0;
  int get score => _score;
  
  final Function(int)? onScoreChanged;
  
  // Flag untuk pause state
  bool _isPaused = false;
  bool get isPaused => _isPaused;

  // Constructor
  FruitCatcherGame({this.onScoreChanged});

  // ==========================================
  // Load game
  // ==========================================
  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}