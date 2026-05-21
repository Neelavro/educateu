import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  final VoidCallback? onTap;

  const VideoTile({super.key, required this.video, this.onTap});

  bool get _isLocked => video.status == VideoStatus.locked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLocked ? null : onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 2.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            SizedBox(width: 3.5.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 0.3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: AppTextStyles.titleSmallEmphasized.copyWith(
                        color: _isLocked
                            ? AppColors.textDisabled
                            : AppColors.textPrimary,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    _buildStatusRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      children: [
        Container(
          width: 120,
          height: 78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E2A38), Color(0xFF2D3E50)],
            ),
          ),
          child: _buildThumbnailOverlay(),
        ),
        if (_isLocked)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgTertiary.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        Positioned(
          right: 6,
          bottom: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              video.duration,
              style: AppTextStyles.labelSmallEmphasized
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildThumbnailOverlay() {
    if (_isLocked) {
      return Center(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.lock, size: 16, color: AppColors.textSecondary),
        ),
      );
    }
    if (video.status == VideoStatus.inProgress) {
      return const Center(
        child: Icon(Icons.play_circle_fill, size: 34, color: Colors.white),
      );
    }
    return null;
  }

  Widget _buildStatusRow() {
    switch (video.status) {
      case VideoStatus.watched:
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
      case VideoStatus.inProgress:
        return Row(
          children: [
            const Icon(Icons.access_time, size: 16, color: AppColors.bgInfo),
            SizedBox(width: 1.5.w),
            Text(
              'In progress',
              style: AppTextStyles.labelLargeEmphasized
                  .copyWith(color: AppColors.bgInfo),
            ),
          ],
        );
      case VideoStatus.locked:
        return Row(
          children: [
            const Icon(Icons.play_circle_outline,
                size: 16, color: AppColors.textDisabled),
            SizedBox(width: 1.5.w),
            Text(
              'Next lesson',
              style: AppTextStyles.labelLarge
                  .copyWith(color: AppColors.textDisabled),
            ),
          ],
        );
    }
  }
}
