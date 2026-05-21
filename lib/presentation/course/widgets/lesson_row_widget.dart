import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/lesson.dart';

class LessonRow extends StatelessWidget {
  final VideoLesson lesson;
  final VoidCallback onTap;

  const LessonRow({super.key, required this.lesson, required this.onTap});

  bool get _isLocked => lesson.status == LessonStatus.locked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildThumbnail(),
          SizedBox(width: 3.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: AppTextStyles.titleSmallEmphasized.copyWith(
                    color: _isLocked
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 1.h),
                _buildStatusLine(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      children: [
        Container(
          width: 96,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A38),
            borderRadius: BorderRadius.circular(10),
          ),
          child: _isLocked
              ? const Center(
                  child: Icon(Icons.lock_outline,
                      size: 22, color: Colors.white70),
                )
              : null,
        ),
        Positioned(
          right: 6,
          bottom: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              lesson.duration,
              style: AppTextStyles.labelSmallEmphasized
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusLine() {
    switch (lesson.status) {
      case LessonStatus.watched:
        return Row(
          children: [
            const Icon(Icons.check_circle, size: 16, color: AppColors.bgSuccess),
            SizedBox(width: 1.5.w),
            Text(
              'Watched',
              style: AppTextStyles.labelLargeEmphasized
                  .copyWith(color: AppColors.bgSuccess),
            ),
          ],
        );
      case LessonStatus.inProgress:
        return Row(
          children: [
            const Icon(Icons.access_time,
                size: 16, color: AppColors.textSecondary),
            SizedBox(width: 1.5.w),
            Text(
              'In progress',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        );
      case LessonStatus.locked:
        return Row(
          children: [
            const Icon(Icons.play_circle_outline,
                size: 16, color: AppColors.textTertiary),
            SizedBox(width: 1.5.w),
            Text(
              'Next lesson',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textTertiary),
            ),
          ],
        );
    }
  }
}
