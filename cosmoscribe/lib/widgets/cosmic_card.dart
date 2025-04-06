import 'package:flutter/material.dart';

class CosmicCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final BorderRadius? borderRadius;
  final Color? color;

  const CosmicCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.elevation = 2,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: elevation,
      color: color ?? Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: card,
      );
    }

    return card;
  }
}
