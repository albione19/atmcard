import 'package:flutter/material.dart';

class AnimatedNeonBackground extends StatefulWidget {
  final Widget child;

  const AnimatedNeonBackground({super.key, required this.child});

  @override
  State<AnimatedNeonBackground> createState() => _AnimatedNeonBackgroundState();
}

class _AnimatedNeonBackgroundState extends State<AnimatedNeonBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> anim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    anim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: anim,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(Colors.blue.shade900, Colors.purple.shade900, anim.value)!,
                Color.lerp(Colors.purple.shade900, Colors.black, anim.value)!,
                Color.lerp(Colors.black, Colors.cyan.shade900, anim.value)!,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
