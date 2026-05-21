import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class AcademicDetailsWidget extends StatelessWidget {
  String title;
  String value;
  AcademicDetailsWidget(this.title,this.value,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(title.isNotEmpty)...[
            Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
          ],
          Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
