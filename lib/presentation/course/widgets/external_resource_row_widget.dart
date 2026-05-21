import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/material.dart';

class ExternalResourceRow extends StatelessWidget {
  final ExternalResource resource;
  final VoidCallback onTap;

  const ExternalResourceRow({
    super.key,
    required this.resource,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          children: [
            const Icon(Icons.link_rounded,
                size: 22, color: AppColors.textSecondary),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.title,
                    style: AppTextStyles.titleSmallEmphasized
                        .copyWith(color: AppColors.textPrimary, height: 1.25),
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    resource.url,
                    style: AppTextStyles.labelLarge
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            SizedBox(width: 3.w),
            const Icon(Icons.open_in_new_rounded,
                size: 20, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
