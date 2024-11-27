import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedDialog extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AnimatedDialog({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
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
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(pi * (1 - _animation.value)),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

// Usage example:
// showDialog(
//   context: context,
//   builder: (context) => AnimatedDialog(
//     child: Dialog(
//       child: YourDialogContent(),
//     ),
//   ),
// );
