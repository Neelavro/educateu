

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class ToggleInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool isEnabled;
  final VoidCallback onToggle;

  const ToggleInfoWidget({
    super.key,
    required this.title,
    required this.value,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelLargeEmphasized
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.bodyLarge
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 48,
            height: 28,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppColors.textInfoPrimary
                  : AppColors.textTertiary.withOpacity(0.25),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment:
              isEnabled ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}