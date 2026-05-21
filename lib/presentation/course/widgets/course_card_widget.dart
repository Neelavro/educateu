import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import 'next_session_card.dart';

class CourseCardWidget extends StatelessWidget {
  final String type;
  final String title;
  final String instructor;
  final int progress;
  final Color accentColor;
  final HeroIcons icon;
  final String? nextSession;
  final bool withdrawn;
  final VoidCallback? onTap;

  const CourseCardWidget({
    super.key,
    required this.type,
    required this.title,
    required this.instructor,
    required this.progress,
    required this.accentColor,
    required this.icon,
    this.nextSession,
    this.withdrawn = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = progress == 100;
    final bool inProgress = progress > 0 && !isCompleted;

    final statusLabel = isCompleted
        ? 'Completed'
        : inProgress
            ? 'In Progress'
            : 'Not Started';
    final statusBg = isCompleted
        ? const Color(0xFFDCFCE7)
        : inProgress
            ? AppColors.bgInfoPrimary
            : AppColors.bgTertiary;
    final statusTextColor = isCompleted
        ? AppColors.textSuccess
        : inProgress
            ? AppColors.textInfoPrimary
            : AppColors.textSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
      opacity: withdrawn ? 0.55 : 1.0,
      child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Color(0xFF006A6A), width: 2),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 10, 30, 0.04),
            blurRadius: 40.107,
            offset: Offset(0, 20.053),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (withdrawn) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFCEEEE),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Text(
                'Withdrawn',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 16 / 12,
                  letterSpacing: 0.5,
                  color: Color(0xFFB3261E),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: AppColors.pillColor,
            ),
            child: Text(type),
          ),
          SizedBox(height: 1.5.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleSmallEmphasized
                          .copyWith(color: AppColors.textPrimary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      instructor,
                      style: AppTextStyles.labelSmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Row(
            children: [
              Expanded(child: Text('COURSE PROGRESS', style: AppTextStyles.titleMedium.copyWith(color: AppColors.textSecondary),)),
              Text('$progress%', style: AppTextStyles.titleMedium.copyWith(color: AppColors.textInfoPrimary),),

            ],
          ),
          SizedBox(height: 1.5.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10025.664),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 8.021,
              backgroundColor: const Color(0xFFE7E8E9),
              valueColor: const AlwaysStoppedAnimation(AppColors.iconInfoPrimary),
            ),
          ),
          if (nextSession != null) ...[
            const SizedBox(height: 16),
            NextSessionCard(dateTimeLabel: nextSession!),
          ],
          const SizedBox(height: 16),
        ],
      ),
    ),
    ),
    );
  }
}
