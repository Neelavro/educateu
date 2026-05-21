import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/material.dart';

class FileCard extends StatelessWidget {
  final MaterialFile file;
  final VoidCallback onDownload;

  const FileCard({super.key, required this.file, required this.onDownload});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: AppColors.primary),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(1.75.h),
                  child: Row(
                    children: [
                      _buildFileIcon(),
                      SizedBox(width: 3.5.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              file.title,
                              style: AppTextStyles.titleSmallEmphasized
                                  .copyWith(
                                color: AppColors.textPrimary,
                                height: 1.25,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              file.meta,
                              style: AppTextStyles.labelLarge
                                  .copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 3.w),
                      _buildDownloadButton(),
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

  Widget _buildFileIcon() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.picture_as_pdf_outlined,
        size: 22,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildDownloadButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onDownload,
      child: Container(
        width: 38,
        height: 38,
        decoration: const BoxDecoration(
          color: AppColors.bgSecondary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.download_rounded,
          size: 19,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
