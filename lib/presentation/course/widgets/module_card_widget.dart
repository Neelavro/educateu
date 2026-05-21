import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/module.dart';
import 'in_progress_module_body.dart';

export '../models/module.dart';

class ModuleCard extends StatelessWidget {
  final Module module;
  final ValueChanged<bool> onDownloadToggle;
  final VoidCallback onResume;
  final VoidCallback onRedownload;

  const ModuleCard({
    super.key,
    required this.module,
    required this.onDownloadToggle,
    required this.onResume,
    required this.onRedownload,
  });

  bool get _isLocked => module.status == ModuleStatus.locked;

  Color get _accentColor {
    switch (module.status) {
      case ModuleStatus.completed:
        return AppColors.bgSuccess;
      case ModuleStatus.inProgress:
        return AppColors.bgBrand;
      case ModuleStatus.locked:
        return AppColors.borderPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isLocked ? AppColors.bgSecondary : AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(16),
        border: _isLocked ? Border.all(color: AppColors.borderPrimary) : null,
        boxShadow: _isLocked
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: _accentColor),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(2.h),
                  child: _buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (module.status) {
      case ModuleStatus.completed:
        return _buildCompletedBody();
      case ModuleStatus.inProgress:
        return _buildInProgressBody();
      case ModuleStatus.locked:
        return _buildLockedBody();
    }
  }

  Widget _buildHeader({required Widget trailing}) {
    return Row(
      children: [
        _StatusPill(status: module.status),
        SizedBox(width: 3.w),
        Text(
          'Module ${module.number}',
          style: AppTextStyles.titleSmallEmphasized.copyWith(
            color: _isLocked ? AppColors.textTertiary : AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        trailing,
      ],
    );
  }

  Widget _buildModuleTitle() {
    return Text(
      module.title,
      style: AppTextStyles.titleLargeEmphasized.copyWith(
        color: _isLocked ? AppColors.textTertiary : AppColors.textPrimary,
      ),
    );
  }

  Widget _buildCompletedBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          trailing: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.bgSuccess,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 15, color: Colors.white),
          ),
        ),
        SizedBox(height: 1.5.h),
        _buildModuleTitle(),
        SizedBox(height: 2.h),
        const Divider(height: 1, color: AppColors.borderPrimary),
        SizedBox(height: 2.h),
        _buildOfflineRow(),
      ],
    );
  }

  Widget _buildInProgressBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(trailing: const SizedBox.shrink()),
        SizedBox(height: 1.5.h),
        _buildModuleTitle(),
        SizedBox(height: 2.h),
        InProgressModuleBody(
          module: module,
          onDownloadToggle: onDownloadToggle,
          onResume: onResume,
          onRedownload: onRedownload,
        ),
      ],
    );
  }

  Widget _buildLockedBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          trailing: const Icon(
            Icons.lock_outline,
            size: 20,
            color: AppColors.textTertiary,
          ),
        ),
        SizedBox(height: 1.5.h),
        _buildModuleTitle(),
        SizedBox(height: 2.h),
        Text(
          module.lockedMessage ?? '',
          style: AppTextStyles.bodyLarge
              .copyWith(color: AppColors.textTertiary, height: 1.55),
        ),
      ],
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

class _StatusPill extends StatelessWidget {
  final ModuleStatus status;
  const _StatusPill({required this.status});

  @override
  Widget build(BuildContext context) {
    late final String label;
    late final Color bg;
    late final Color fg;

    switch (status) {
      case ModuleStatus.completed:
        label = 'Completed';
        bg = AppColors.bgSuccess.withValues(alpha: 0.12);
        fg = AppColors.bgSuccess;
        break;
      case ModuleStatus.inProgress:
        label = 'In Progress';
        bg = AppColors.bgBrand.withValues(alpha: 0.12);
        fg = AppColors.bgBrand;
        break;
      case ModuleStatus.locked:
        label = 'Locked';
        bg = AppColors.textTertiary.withValues(alpha: 0.12);
        fg = AppColors.textTertiary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMediumEmphasized.copyWith(color: fg),
      ),
    );
  }
}
