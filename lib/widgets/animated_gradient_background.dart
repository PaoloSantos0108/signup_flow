import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  
  const AnimatedGradientBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _animation4;
  
  final List<Color> _colors = [
    const Color(0xFFE53935),
    const Color(0xFFB71C1C),
    const Color(0xFFD32F2F),
    const Color(0xFFC62828),
  ];

  @override
  void initState() {
    super.initState();
    
    _controller1 = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
    
    _controller2 = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation1 = Tween<double>(begin: 0, end: 1).animate(_controller1);
    _animation2 = Tween<double>(begin: 0, end: 1).animate(_controller2);
    _animation3 = Tween<double>(begin: 0.3, end: 0.7).animate(_controller1);
    _animation4 = Tween<double>(begin: 0.4, end: 0.8).animate(_controller2);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller1, _controller2]),
      builder: (context, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                math.cos(_animation1.value * 2 * math.pi),
                math.sin(_animation1.value * 2 * math.pi),
              ),
              end: Alignment(
                math.cos(_animation2.value * 2 * math.pi + math.pi),
                math.sin(_animation2.value * 2 * math.pi + math.pi),
              ),
              colors: [
                Color.lerp(_colors[0], _colors[1], _animation3.value)!,
                Color.lerp(_colors[2], _colors[3], _animation4.value)!,
              ],
            ),
          ),
          child: CustomPaint(
            painter: WavePainter(
              wavePhase: _animation1.value * 2 * math.pi,
              waveAmplitude: 0.1 + 0.05 * math.sin(_animation2.value * math.pi),
            ),
            size: Size.infinite,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double wavePhase;
  final double waveAmplitude;
  
  WavePainter({
    required this.wavePhase,
    required this.waveAmplitude,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * (0.3 + 0.05 * math.sin(wavePhase)));
    
    for (int i = 0; i <= 10; i++) {
      final x = size.width * (i / 10);
      final y = size.height * (0.3 + waveAmplitude * math.sin(wavePhase + i * math.pi / 5));
      path1.lineTo(x, y);
    }
    
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    final path2 = Path();
    path2.moveTo(0, size.height * (0.5 + 0.05 * math.sin(wavePhase + math.pi / 2)));
    
    for (int i = 0; i <= 10; i++) {
      final x = size.width * (i / 10);
      final y = size.height * (0.5 + waveAmplitude * math.sin(wavePhase + math.pi / 2 + i * math.pi / 5));
      path2.lineTo(x, y);
    }
    
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint..color = Colors.white.withOpacity(0.15));
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => 
    oldDelegate.wavePhase != wavePhase || 
    oldDelegate.waveAmplitude != waveAmplitude;
}

