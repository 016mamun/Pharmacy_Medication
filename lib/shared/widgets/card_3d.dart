import 'package:flutter/material.dart';

/// A card widget styled with a 3D raised effect using layered box shadows,
/// a subtle top-highlight gradient, and a bottom-edge depth border.
class Card3D extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets? padding;
  final Color? baseColor;
  final VoidCallback? onTap;

  const Card3D({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.baseColor,
    this.onTap,
  });

  @override
  State<Card3D> createState() => _Card3DState();
}

class _Card3DState extends State<Card3D> with SingleTickerProviderStateMixin {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final base = widget.baseColor ?? Colors.white;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: _pressed
            ? (Matrix4.identity()..translateByDouble(0, 3, 0, 1))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: base,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.alphaBlend(Colors.white.withValues(alpha: 0.6), base),
              base,
              Color.alphaBlend(Colors.black.withValues(alpha: 0.04), base),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [
                  // Top-left highlight (white)
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.9),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: const Offset(-1, -1),
                  ),
                  // Right & bottom dark shadow (depth)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.20),
                    blurRadius: 8,
                    offset: const Offset(4, 6),
                  ),
                  // Soft ambient shadow
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                  // Bottom edge depth line
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// A static helper that returns the 3D BoxDecoration for use inside
/// existing Container widgets (no tap animation).
class AppCardDecoration {
  static BoxDecoration get decoration3D => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFF6F8FA),
            Color(0xFFEEF0F3),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(-1, -1),
          ),
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(4, 6),
          ),
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration decoration3DColored(Color base) => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(Colors.white.withValues(alpha: 0.5), base),
            base,
            Color.alphaBlend(Colors.black.withValues(alpha: 0.08), base),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 8,
            offset: const Offset(4, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      );
}
