import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';


class AcademicInfoRow extends StatefulWidget {
  final List<String>? academicInfo;

  const AcademicInfoRow({super.key, this.academicInfo});

  @override
  State<AcademicInfoRow> createState() => _AcademicInfoRowState();
}

class _AcademicInfoRowState extends State<AcademicInfoRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final list = widget.academicInfo ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HeroIcon(HeroIcons.academicCap, color: AppColors.iconTertiary, size: 15),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                list.isEmpty ? '—' : list.first,
                style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textTertiary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (list.length > 1)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: HeroIcon(
                  _expanded ? HeroIcons.chevronUp : HeroIcons.chevronDown,
                  color: AppColors.iconPrimary,
                  size: 20,
                ),
              ),
          ],
        ),
        if (list.length > 1 && _expanded)
          ...list.skip(1).map((item) => Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Row(
              children: [
                SizedBox(width: 15 + 2.w),
                Expanded(
                  child: Text(
                    item,
                    style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textTertiary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
      ],
    );
  }
}