import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class AchieveSectionWidget extends StatelessWidget {

  const AchieveSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // your child widgets here, spaced by SizedBox(height: 12)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 17,vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.bgWarningPrimary,
          ),
          child: Image.asset("assets/achievement.png",height: 20,)
        ),
        SizedBox(width: 2.w,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("3 Certifications",
              style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary),),
            SizedBox(height: 0.5.h,),
            Text("Recently earned UI Design",
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("12 Badges",
              style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary),),
            SizedBox(height: 0.5.h,),
            Text("Earned",
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textPrimary),),
          ],
        ),
      ],
    );
  }
}
