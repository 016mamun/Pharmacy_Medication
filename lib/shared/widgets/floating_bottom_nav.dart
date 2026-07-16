import 'package:flutter/material.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FloatingBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _NavIcon(
              icon: Icons.home_rounded,
              index: 0,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
          Expanded(
            child: _NavIcon(
              icon: Icons.favorite_border_rounded,
              index: 1,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
          Expanded(
            child: _NavIcon(
              icon: Icons.upload_outlined,
              index: 2,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
          Expanded(
            child: _NavIcon(
              icon: Icons.shopping_cart_outlined,
              index: 3,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
          Expanded(
            child: _NavIcon(
              icon: Icons.headset_mic_outlined,
              index: 4,
              currentIndex: currentIndex,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavIcon({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isActive ? 44 : 36,
        height: isActive ? 44 : 36,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? AppColors.white : AppColors.white.withValues(alpha: 0.85),
          size: isActive ? 22 : 20,
        ),
      ),
    );
  }
}
