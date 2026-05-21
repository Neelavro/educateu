import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/material.dart';

class ReadingCard extends StatelessWidget {
  final RequiredReading reading;
  final VoidCallback onOpen;

  const ReadingCard({super.key, required this.reading, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(2.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A5F), Color(0xFF0F2235)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.menu_book_outlined, size: 24, color: AppColors.bgWarning),
          SizedBox(height: 2.h),
          Text(
            reading.title,
            style: AppTextStyles.titleLargeEmphasized.copyWith(
              color: Colors.white,
              height: 1.3,
            ),
          ),
          SizedBox(height: 1.5.h),
          Text(
            reading.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
              height: 1.55,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  reading.readTime,
                  style: AppTextStyles.labelMediumEmphasized.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onOpen,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.5.h),
                  child: Row(
                    children: [
                      Text(
                        'OPEN READER',
                        style: AppTextStyles.labelLargeEmphasized.copyWith(
                          color: AppColors.bgWarning,
                        ),
                      ),
                      SizedBox(width: 1.5.w),
                      Icon(Icons.arrow_forward, size: 16, color: AppColors.bgWarning),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
