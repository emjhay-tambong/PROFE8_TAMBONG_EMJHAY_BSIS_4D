import 'package:flutter/material.dart';

// Custom icon set for bike-related features - Requirement 14
class CustomBikeIcons {
  // Custom bike icon with gradient
  static Widget bikeIcon({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(
        Icons.directions_bike,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }

  // Custom rental icon
  static Widget rentalIcon({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.2),
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(
        Icons.local_shipping,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }

  // Custom maintenance icon
  static Widget maintenanceIcon({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
        color: color.withValues(alpha: 0.1),
      ),
      child: Icon(
        Icons.build,
        size: size * 0.5,
        color: color,
      ),
    );
  }

  // Custom speedometer icon
  static Widget speedIcon({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.3),
            color,
          ],
        ),
      ),
      child: Icon(
        Icons.speed,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }

  // Custom location pin for bike stations
  static Widget stationIcon({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.location_on,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }

  // Custom eco-friendly icon
  static Widget ecoIcon({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Colors.green, Colors.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(
        Icons.eco,
        size: size * 0.6,
        color: Colors.white,
      ),
    );
  }
}

// Custom animated bike icon
class AnimatedBikeIcon extends StatefulWidget {
  final double size;
  final Color color;
  final bool isAnimating;

  const AnimatedBikeIcon({
    super.key,
    required this.size,
    required this.color,
    this.isAnimating = false,
  });

  @override
  State<AnimatedBikeIcon> createState() => _AnimatedBikeIconState();
}

class _AnimatedBikeIconState extends State<AnimatedBikeIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedBikeIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating && !oldWidget.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isAnimating && oldWidget.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 6.28, // Full rotation
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  widget.color,
                  widget.color.withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.directions_bike,
              size: widget.size * 0.6,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
