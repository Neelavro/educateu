import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/module.dart';

class InProgressModuleBody extends StatelessWidget {
  final Module module;
  final ValueChanged<bool> onDownloadToggle;
  final VoidCallback onResume;
  final VoidCallback onRedownload;

  const InProgressModuleBody({
    super.key,
    required this.module,
    required this.onDownloadToggle,
    required this.onResume,
    required this.onRedownload,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildResumeButton(),
        SizedBox(height: 1.5.h),
        module.isDownloaded ? _buildOfflineRow() : _buildDownloadToggleRow(),
      ],
    );
  }

  Widget _buildResumeButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF2A7FA8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onResume,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_forward, color: Colors.white, size: 19),
                SizedBox(width: 3.w),
                Text(
                  'Resume Module',
                  style: AppTextStyles.titleMediumEmphasized
                      .copyWith(color: AppColors.textInverse),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadToggleRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.25.h),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.download_rounded,
              size: 20, color: AppColors.textPrimary),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              'Download for Offline',
              style: AppTextStyles.bodyLarge
                  .copyWith(color: AppColors.textPrimary),
            ),
          ),
          Switch.adaptive(
            value: module.isDownloaded,
            onChanged: onDownloadToggle,
            activeColor: Colors.white,
            activeTrackColor: AppColors.bgInfo,
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineRow() {
    return Row(
      children: [
        const Icon(Icons.cloud_done_outlined,
            size: 20, color: AppColors.textSecondary),
        SizedBox(width: 3.w),
        Expanded(
          child: Text(
            'Available offline',
            style: AppTextStyles.bodyLarge
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onRedownload,
          child: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.bgSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.download_rounded,
                size: 18, color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
