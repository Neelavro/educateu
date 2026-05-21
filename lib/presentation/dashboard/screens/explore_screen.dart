import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../widgets/assignment_card_widget.dart';
import '../widgets/course_progress_card_widget.dart';
import '../widgets/stat_card_widget.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  static const _items = [
    {
      'name': 'Quantum Physics',
      'subtitle': 'Advanced Mechanics III',
      'percentage': '48',
    },
    {
      'name': 'Quantum Physics',
      'subtitle': 'Advanced Mechanics III',
      'percentage': '48',
    },
  ];
  static const _assignments = [
    {
      'month': 'Oct',
      'day': '12',
      'title': 'Midterm Exam',
      'subtitle': 'Quantum Mechanics Fundamentals',
      'isUrgent': true,
    },
    {
      'month': 'Oct',
      'day': '12',
      'title': 'Literature Review',
      'subtitle': 'Great Expectations Analysis',
      'isUrgent': false,
    },
    {
      'month': 'Oct',
      'day': '12',
      'title': 'Lab Report',
      'subtitle': 'Applied Electromagnetics',
      'isUrgent': false,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgTertiary,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.bgPrimary,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('EducateU', style: AppTextStyles.titleLargeEmphasized.copyWith(color: AppColors.textPrimary),),
            HeroIcon(HeroIcons.bellAlert, size: 24, color: AppColors.iconPrimary, style: HeroIconStyle.solid),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good Morning', style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)),
              SizedBox(height: 1.h,),
              Text('Welcome back, Alex!', style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary)),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatCardWidget(
                    icon: HeroIcons.academicCap,
                    iconStyle: HeroIconStyle.solid,
                    iconColor: AppColors.primary,
                    topText: '4',
                    topTextColor: AppColors.textPrimary,
                    bottomText: 'Courses',
                    bottomTextColor: AppColors.textSecondary,
                    backgroundColor: AppColors.bgPrimary,

                  ),
                  StatCardWidget(
                    icon: HeroIcons.star,
                    iconStyle: HeroIconStyle.solid,
                    iconColor: Color(0xff006E6E),
                    topText: '86%',
                    topTextColor:  Color(0xff006E6E),
                    bottomText: 'Avg Grade',
                    bottomTextColor: Color(0xff006E6E),
                    backgroundColor: Color(0xff90EFEF),
                  ),
                  StatCardWidget(
                    icon: HeroIcons.arrowTrendingUp,
                    iconStyle: HeroIconStyle.solid,
                    iconColor: AppColors.iconPrimary,
                    topText: '71%',
                    topTextColor: AppColors.textPrimary,
                    bottomText: 'Progress',
                    bottomTextColor: AppColors.textSecondary,
                    backgroundColor: AppColors.bgPrimary,

                  ),
                  StatCardWidget(
                    icon: HeroIcons.clipboardDocumentList,
                    iconStyle: HeroIconStyle.solid,
                    iconColor: Color(0xffEBDDFF),
                    topText: '12',
                    topTextColor: Color(0xffEBDDFF),
                    bottomText: 'Pend Tasks',
                    bottomTextColor: Color(0xffEBDDFF),
                    backgroundColor: Color(0xff110030),

                  )
                ],
              ),
              SizedBox(height: 2.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.bgInverse,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.bgGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('CURRENT MODULE',style: AppTextStyles.labelLarge.copyWith(color: AppColors.textInverse),),
                    ),
                    SizedBox(height: 2.h),
                    Text('Quantum Physics: \nWave- article Duality',style: AppTextStyles.headlineMediumEmphasized.copyWith(color: AppColors.textInverse),),
                    SizedBox(height: 2.h),
                    Text('Continue where you left off. Only 15 minutes left in this chapter to complete your weekly goal.',
                      style: AppTextStyles.titleMedium.copyWith(color: AppColors.textBrand),),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(17),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.bgGreen,width: 3),
                          ),
                          child: Text('65%',style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textInverse,) ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.bgGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              HeroIcon(HeroIcons.playCircle,color: AppColors.iconInverse,style: HeroIconStyle.solid,),
                              SizedBox(width: 1.w,),
                              Text('CURRENT MODULE',style: AppTextStyles.labelLarge.copyWith(color: AppColors.textInverse),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Active Courses', style: AppTextStyles.headlineSmallEmphasized.copyWith(color: AppColors.textPrimary)),
                  Text('View All', style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.primary)),
                ],
              ),
              SizedBox(height: 2.h,),
              ListView.separated(
                itemCount: _items.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return CourseProgressCard(
                    name: item['name']!,
                    subtitle: item['subtitle']!,
                    percentage: item['percentage']!,
                  );
                },
              ),
              SizedBox(height: 2.h,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assignments', style: AppTextStyles.headlineSmallEmphasized.copyWith(color: AppColors.textPrimary)),
                    SizedBox(height: 2.h,),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: _assignments.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = _assignments[index];
                        return AssignmentCard(
                          month: item['month'] as String,
                          day: item['day'] as String,
                          title: item['title'] as String,
                          subtitle: item['subtitle'] as String,
                          isUrgent: item['isUrgent'] as bool,
                        );
                      },
                    ),
                    SizedBox(height: 2.h,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.borderPrimary)
                            ),
                            child: Center(child: Text('View Assignment Calendar',style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.primary),)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10.h,),

            ],
          ),
        ),
      ),
    );
  }
}
