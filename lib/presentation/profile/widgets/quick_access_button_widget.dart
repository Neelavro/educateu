import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class QuickAccessButtonWidget extends StatelessWidget {
  String title;
  HeroIcons icon;
  QuickAccessButtonWidget({required this.title, required this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 0.8.h,),

          // your child widgets here, spaced by SizedBox(height: 12)
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.bgInfoPrimary,
            ),
            child: HeroIcon(icon, size: 20,style: HeroIconStyle.solid,color: AppColors.iconInfoPrimary,),
          ),
          SizedBox(height: 2.h,),
          Text(title,
            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary),),
        ],
      ),
    );
  }
}
