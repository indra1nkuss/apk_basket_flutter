import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import './fruit_catcher_game.dart';

class Basket extends PositionComponent 
    with HasGameReference<FruitCatcherGame>, 
         CollisionCallbacks,
         DragCallbacks {
  
  Basket() : super(size: Vector2(80, 60));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Posisi: tengah bawah layar
    position = Vector2(game.size.x / 2, game.size.y - 100);
    anchor = Anchor.center;
    
    // HITBOX: Sesuaikan dengan ukuran keranjang
    add(RectangleHitbox(
      size: Vector2(70, 50),  // Sedikit lebih kecil dari visual
      position: Vector2(5, 5),  // Offset ke tengah
    )..collisionType = CollisionType.passive);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    
    // Gerakkan keranjang
    position.x += event.localDelta.x;
    
    // Batasi layar
    position.x = position.x.clamp(
      size.x / 2, 
      game.size.x - size.x / 2
    );
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw basket body
    final paint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.x, size.y),
      const Radius.circular(10),
    );
    canvas.drawRRect(rect, paint);

    // Draw handle
    final handlePaint = Paint()
      ..color = Colors.brown[800]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final handlePath = Path()
      ..moveTo(10, 0)
      ..quadraticBezierTo(size.x / 2, -20, size.x - 10, 0);

    canvas.drawPath(handlePath, handlePaint);
  }
}