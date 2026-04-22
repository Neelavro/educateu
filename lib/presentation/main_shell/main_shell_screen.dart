import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

import '../../core/colors.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 👈 add this
      body: navigationShell,
      bottomNavigationBar: _FloatingNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingNavBar({required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem(icon: HeroIcons.home, activeIcon: HeroIcons.home, label: 'Explore'),
    _NavItem(icon: HeroIcons.academicCap, activeIcon: HeroIcons.academicCap, label: 'Courses'),
    _NavItem(icon: HeroIcons.clipboardDocumentList, activeIcon: HeroIcons.clipboardDocumentList, label: 'Exam'),
    _NavItem(icon: HeroIcons.envelope, activeIcon: HeroIcons.envelope, label: 'Inbox'),
    _NavItem(icon: HeroIcons.userCircle, activeIcon: HeroIcons.userCircle, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (i) {
            final item = _items[i];
            final isActive = i == currentIndex;
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 17),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF013E5B).withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: HeroIcon(
                        item.icon,
                        style: isActive ? HeroIconStyle.solid : HeroIconStyle.outline,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textTertiary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.label,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textTertiary,
                        fontSize: 11,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItem {
  final HeroIcons icon;
  final HeroIcons activeIcon;
  final String label;
  const _NavItem({required this.icon, required this.activeIcon, required this.label});
}