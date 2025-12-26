import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EncouragingWaveButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final double height;
  final double radius;
  final Color backgroundColor;
  final Color waveColor;

  const EncouragingWaveButton({
    super.key,
    required this.onTap,
    required this.child,
    this.height = 48,
    this.radius = 40,
    required this.backgroundColor,
    this.waveColor = Colors.white,
  });

  @override
  State<EncouragingWaveButton> createState() => _EncouragingWaveButtonState();
}

class _EncouragingWaveButtonState extends State<EncouragingWaveButton>
    with TickerProviderStateMixin {
  late AnimationController _waveController1;
  late AnimationController _waveController2;
  late AnimationController _waveController3;
  late AnimationController _scaleController;

  late Animation<double> _wave1;
  late Animation<double> _wave2;
  late Animation<double> _wave3;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _waveController1 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _waveController2 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _waveController3 = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );

    _wave1 = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _waveController1, curve: Curves.easeOut),
    );

    _wave2 = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _waveController2, curve: Curves.easeOut),
    );

    _wave3 = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _waveController3, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) _waveController2.repeat();
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) _waveController3.repeat();
    });
  }

  @override
  void dispose() {
    _waveController1.dispose();
    _waveController2.dispose();
    _waveController3.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _scaleController.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _wave1,
          _wave2,
          _wave3,
          _scaleAnimation,
        ]),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildWave(_wave3.value, (1.0 - _waveController3.value).toInt()),
              _buildWave(_wave2.value, (1.0 - _waveController2.value).toInt()),
              _buildWave(_wave1.value, (1.0 - _waveController1.value).toInt()),

              Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  height: widget.height,
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.circular(widget.radius),
                    boxShadow: [
                      BoxShadow(
                        color: widget.backgroundColor.withAlpha(128),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: widget.child,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 🔵 UPDATED FILLED WAVE BUILDER
  Widget _buildWave(double scale, int opacity) {
    return Transform.scale(
      scale: scale,
      child: Container(
        height: widget.height,
        width: widget.height * 6,
        decoration: BoxDecoration(
          color: widget.waveColor.withAlpha(opacity * 90), // Filled wave
          borderRadius: BorderRadius.circular(widget.radius * scale),
        ),
      ),
    );
  }
}
