import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/material.dart';
import '../widgets/external_resource_row_widget.dart';
import '../widgets/file_card_widget.dart';
import '../widgets/reading_card_widget.dart';

class CourseMaterialsTab extends StatelessWidget {
  const CourseMaterialsTab({super.key});

  static const _coreTextbooks = [
    MaterialFile(
      title: 'Design Patterns: Reusable Elements',
      fileType: 'PDF',
      fileSize: '12.4 MB',
    ),
    MaterialFile(
      title: 'Clean Architecture Guide',
      fileType: 'PDF',
      fileSize: '8.1 MB',
    ),
  ];

  static const _requiredReading = RequiredReading(
    title: 'Microservices vs. Monoliths: A Comparative Study',
    description:
        'An in-depth analysis of architectural shifts in modern enterprise '
        'software.',
    readTime: '15 MIN READ',
  );

  static const _externalResources = [
    ExternalResource(
      title: 'AWS Well-Architected Framework',
      url: 'aws.amazon.com/architecture',
    ),
    ExternalResource(
      title: 'GitHub: Engineering Standards',
      url: 'github.com/engineering',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 2.h, 20, 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoreTextbooks(),
          SizedBox(height: 2.5.h),
          _buildRequiredReading(),
          SizedBox(height: 2.5.h),
          _buildExternalResources(),
        ],
      ),
    );
  }

  Widget _buildCoreTextbooks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          'Core Textbooks',
          trailing: _buildCountBadge('${_coreTextbooks.length} FILES'),
        ),
        SizedBox(height: 1.5.h),
        ..._coreTextbooks.map(
          (f) => Padding(
            padding: EdgeInsets.only(bottom: 1.5.h),
            child: FileCard(file: f, onDownload: () {}),
          ),
        ),
      ],
    );
  }

  Widget _buildRequiredReading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Required Reading'),
        SizedBox(height: 1.5.h),
        ReadingCard(reading: _requiredReading, onOpen: () {}),
      ],
    );
  }

  Widget _buildExternalResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('External Resources'),
        SizedBox(height: 1.5.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.bgPrimary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.5.w),
          child: Column(
            children: [
              for (int i = 0; i < _externalResources.length; i++) ...[
                ExternalResourceRow(
                  resource: _externalResources[i],
                  onTap: () {},
                ),
                if (i != _externalResources.length - 1)
                  const Divider(height: 1, color: AppColors.borderPrimary),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {Widget? trailing}) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.titleMediumEmphasized
              .copyWith(color: AppColors.textPrimary),
        ),
        if (trailing != null) ...[const Spacer(), trailing],
      ],
    );
  }

  Widget _buildCountBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.bgWarning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelMediumEmphasized
            .copyWith(color: AppColors.bgWarning),
      ),
    );
  }
}
