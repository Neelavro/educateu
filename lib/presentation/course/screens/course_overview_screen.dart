import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';

class CourseOverviewTab extends StatelessWidget {
  const CourseOverviewTab({super.key, required this.instructor});

  final String instructor;

  static const _learnPoints = [
    'Architect high-performance distributed systems.',
    'Implement advanced design patterns in production.',
    'Master CI/CD pipelines and automated QA.',
    'Design robust APIs for microservices architecture.',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAboutSection(),
          SizedBox(height: 2.h),
          const Divider(color: AppColors.borderPrimary, height: 1),
          SizedBox(height: 2.h),
          _buildStatsRow(),
          SizedBox(height: 2.h),
          const Divider(color: AppColors.borderPrimary, height: 1),
          SizedBox(height: 2.5.h),
          _buildLearnSection(),
          SizedBox(height: 2.h),
          _buildInstructorCard(),
          SizedBox(height: 2.h),
          _buildResumeButton(),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About the Course',
          style: AppTextStyles.titleMediumEmphasized
              .copyWith(color: AppColors.textPrimary),
        ),
        SizedBox(height: 2.h),
        Text(
          'Master the complexities of modern system architecture and '
          'high-scale software development. This course bridges the gap '
          'between coding and engineering, focusing on scalable design '
          'patterns, distributed systems, and industry-leading quality '
          'standards.',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
            height: 1.55,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return IntrinsicHeight(
      child: Row(
        children: [
          _buildStatItem(Icons.access_time, 'Duration', '24 Hours'),
          _verticalDivider(),
          _buildStatItem(Icons.layers_outlined, 'Modules', '12 Units'),
          _verticalDivider(),
          _buildStatItem(Icons.bar_chart_rounded, 'Level', 'Advanced'),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.primary),
          SizedBox(height: 0.8.h),
          Text(
            label,
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: .2.h),
          Text(
            value,
            style: AppTextStyles.titleSmallEmphasized
                .copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() => const VerticalDivider(
        color: AppColors.borderPrimary,
        width: 1,
        thickness: 1,
        indent: 4,
        endIndent: 4,
      );

  Widget _buildLearnSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What you'll learn",
          style: AppTextStyles.titleMediumEmphasized
              .copyWith(color: AppColors.textPrimary),
        ),
        SizedBox(height: 1.5.h),
        ..._learnPoints.map(_buildLearnRow),
      ],
    );
  }

  Widget _buildLearnRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.8.h),
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: AppColors.bgSuccess,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Instructor',
            style: AppTextStyles.titleMediumEmphasized
                .copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: const Icon(Icons.person, size: 28, color: AppColors.primary),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      instructor,
                      style: AppTextStyles.titleMediumEmphasized
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    SizedBox(height: .3.h),
                    Text(
                      'Senior Software Architect & PhD',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            '"$instructor bridges theory and industry practice with '
            'decades of experience. Their teaching style is rigorous yet deeply intuitive."',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
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
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Resume Module 2',
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
}
