import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x0B1519FF), // Light background color
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Your image path
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
