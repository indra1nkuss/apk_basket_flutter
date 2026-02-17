import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import './fruit_catcher_game.dart';
import './basket.dart';

enum FruitType { apple, banana, orange, strawberry }

class Fruit extends PositionComponent 
    with HasGameReference<FruitCatcherGame>, 
         CollisionCallbacks {
  
  final FruitType type;
  final double fallSpeed = 300;
  static final Random _random = Random();
  
  // VARIABLE PENGAMAN
  bool _isCollected = false; 

  Fruit({super.position})
      : type = FruitType.values[_random.nextInt(FruitType.values.length)],
        super(size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    add(CircleHitbox()
      ..collisionType = CollisionType.active
      ..radius = 15);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += fallSpeed * dt;
    
    if (position.y > game.size.y + 50) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    // Cek jika nabrak Basket DAN belum pernah diambil
    if (other is Basket && !_isCollected) {
      _isCollected = true; // Kunci agar tidak terpanggil lagi
      
      // 1. Efek Visual
      game.add(CatchEffect(position: position.clone(), color: _getColor()));
      
      // 2. Tambah Score & Sound (lewat fungsi di game class)
      game.incrementScore();
      
      // 3. Hapus buah
      removeFromParent();
    }
  }

  // ... (Sisa kode render dan getColor kamu sudah bagus, biarkan saja)
  Color _getColor() {
    switch (type) {
      case FruitType.apple: return Colors.red;
      case FruitType.banana: return Colors.yellow;
      case FruitType.orange: return Colors.orange;
      case FruitType.strawberry: return Colors.pink;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = _getColor();
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
    
    final shinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.x / 2 - 5, size.y / 2 - 5), size.x / 5, shinePaint);
  }
}

// ... (Class CatchEffect biarkan saja, sudah oke)
class CatchEffect extends PositionComponent {
  final Color color;
  double _opacity = 1.0;
  double _scale = 1.0;

  CatchEffect({required Vector2 position, required this.color})
      : super(position: position, size: Vector2.all(50), anchor: Anchor.center);

  @override
  void update(double dt) {
    super.update(dt);
    _opacity -= dt * 3;  // Sedikit dipercepat fade out-nya
    _scale += dt * 3;    
    
    if (_opacity <= 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_opacity <= 0) return;

    final paint = Paint()
      ..color = color.withValues(alpha: _opacity.clamp(0.0, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), (size.x / 2) * _scale, paint);
  }
}