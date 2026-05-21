import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/lesson.dart';

class NoteCard extends StatelessWidget {
  final LessonNote note;
  final VoidCallback onEdit;

  const NoteCard({super.key, required this.note, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: note.accentColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(1.75.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            note.timestamp,
                            style: AppTextStyles.titleSmallEmphasized
                                .copyWith(color: note.accentColor),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: onEdit,
                            child: const Icon(Icons.edit_outlined,
                                size: 18, color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        note.body,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
