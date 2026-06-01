import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class LuxuryBackground extends StatefulWidget {
  final Widget child;

  const LuxuryBackground({super.key, required this.child});

  @override
  State<LuxuryBackground> createState() => _LuxuryBackgroundState();
}

class _LuxuryBackgroundState extends State<LuxuryBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fundo base escuro Obsidian
          Container(
            color: const Color(0xFF070A0F),
          ),
          // Pintor das Orbes Animadas
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _OrbPainter(progress: _controller.value),
                size: Size.infinite,
              );
            },
          ),
          // Filtro de desfoque de vidro para mesclar as orbes suavemente
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ),
          ),
          // Conteúdo acima do fundo
          Positioned.fill(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class _OrbPainter extends CustomPainter {
  final double progress;

  _OrbPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..style = PaintingStyle.fill;
    
    final paint2 = Paint()
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..style = PaintingStyle.fill;

    // Cálculo das posições baseado no progresso (seno/cosseno para mover em órbita)
    final angle = progress * 2 * math.pi;

    // Orbe 1: Sapphire Blue (Superior Esquerda a Centro)
    final x1 = size.width * (0.25 + 0.15 * math.sin(angle));
    final y1 = size.height * (0.3 + 0.1 * math.cos(angle));
    final radius1 = size.width * 0.55;
    paint1.shader = RadialGradient(
      colors: [
        const Color(0xFF0A2E5C).withValues(alpha: 0.7),
        const Color(0xFF0A2E5C).withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset(x1, y1), radius: radius1));
    canvas.drawCircle(Offset(x1, y1), radius1, paint1);

    // Orbe 2: Luxury Deep Purple/Violet (Inferior Direita a Centro)
    final x2 = size.width * (0.75 + 0.15 * math.cos(angle + math.pi));
    final y2 = size.height * (0.7 + 0.15 * math.sin(angle + math.pi));
    final radius2 = size.width * 0.65;
    paint2.shader = RadialGradient(
      colors: [
        const Color(0xFF3B0B59).withValues(alpha: 0.65),
        const Color(0xFF3B0B59).withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset(x2, y2), radius: radius2));
    canvas.drawCircle(Offset(x2, y2), radius2, paint2);

    // Orbe 3: Champagne Gold/Amber (Centro a Superior Direita - mais sutil)
    final x3 = size.width * (0.6 + 0.2 * math.sin(angle * 1.5 + math.pi / 2));
    final y3 = size.height * (0.25 + 0.12 * math.cos(angle * 1.2));
    final radius3 = size.width * 0.45;
    paint3.shader = RadialGradient(
      colors: [
        const Color(0xFF6B531E).withValues(alpha: 0.45),
        const Color(0xFF6B531E).withValues(alpha: 0.0),
      ],
    ).createShader(Rect.fromCircle(center: Offset(x3, y3), radius: radius3));
    canvas.drawCircle(Offset(x3, y3), radius3, paint3);
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
