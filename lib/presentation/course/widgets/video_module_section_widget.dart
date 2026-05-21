import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/video.dart';
import 'video_tile_widget.dart';

class VideoModuleSection extends StatelessWidget {
  final VideoModule module;
  final ValueChanged<Video>? onLessonTap;

  const VideoModuleSection({super.key, required this.module, this.onLessonTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 1.5.h, 20, 2.h),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: module.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 2.5.w),
              Text(
                module.title,
                style: AppTextStyles.titleSmallEmphasized
                    .copyWith(color: AppColors.textPrimary),
              ),
              const Spacer(),
              Text(
                '${module.videoCount} Videos • ${module.duration}',
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        ...module.videos.map((v) => VideoTile(
              video: v,
              onTap: onLessonTap != null ? () => onLessonTap!(v) : null,
            )),
      ],
    );
  }
}
