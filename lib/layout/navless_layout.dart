import 'package:flutter/material.dart';

class NavlessLayout extends StatelessWidget {

  const NavlessLayout({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).colorScheme.surface;
    return Scaffold(
      backgroundColor: bg,
      body: child,
    );
  }
}
