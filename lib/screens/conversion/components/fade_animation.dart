import 'package:flutter/material.dart';

class FadeInItem extends StatefulWidget {
  final int index;
  final Widget child;
  const FadeInItem({super.key, required this.index, required this.child});

  @override
  FadeInItemState createState() => FadeInItemState();
}

class FadeInItemState extends State<FadeInItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
