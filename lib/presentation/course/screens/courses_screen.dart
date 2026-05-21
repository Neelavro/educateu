import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../widgets/course_card_widget.dart';

class _CourseItem {
  final String type;
  final String title;
  final String instructor;
  final int progress;
  final Color accentColor;
  final HeroIcons icon;
  final bool withdrawn;
  final String? nextSession;

  const _CourseItem({
    required this.type,
    required this.title,
    required this.instructor,
    required this.progress,
    required this.accentColor,
    required this.icon,
    this.withdrawn = false,
    this.nextSession,
  });
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int _selectedFilter = 0;
  final _filters = ['Active', 'Completed', 'Withdrawn'];

  final _allCourses = [
    // Active
    const _CourseItem(
      type: 'Science & Logic',
      title: 'Mathematical Modeling',
      instructor: 'Prof. Emily Carter',
      progress: 65,
      accentColor: AppColors.primary,
      icon: HeroIcons.beaker,
      nextSession: 'Wednesday, 02:00 PM',
    ),
    const _CourseItem(
      type: 'Science & Logic',
      title: 'Biophysics',
      instructor: 'Prof. Charlotte Brontë',
      progress: 75,
      accentColor: Color(0xFF6366F1),
      icon: HeroIcons.bookOpen,
      nextSession: 'Thursday, 10:00 AM',
    ),
    const _CourseItem(
      type: 'Humanities',
      title: 'World History: Modern Era',
      instructor: 'Prof. Howard Zinn',
      progress: 40,
      accentColor: Color(0xFFF59E0B),
      icon: HeroIcons.globeAlt,
      nextSession: 'Monday, 09:00 AM',
    ),
    const _CourseItem(
      type: 'Technology',
      title: 'Introduction to Computer Science',
      instructor: 'Prof. Grace Hopper',
      progress: 20,
      accentColor: Color(0xFF8B5CF6),
      icon: HeroIcons.cpuChip,
      nextSession: 'Friday, 11:00 AM',
    ),
    // Completed
    const _CourseItem(
      type: 'Science & Logic',
      title: 'Calculus II',
      instructor: 'Dr. Alan Turing',
      progress: 100,
      accentColor: AppColors.bgGreen,
      icon: HeroIcons.chartBar,
    ),
    const _CourseItem(
      type: 'Humanities',
      title: 'English Literature',
      instructor: 'Prof. Jane Austen',
      progress: 100,
      accentColor: Color(0xFFEC4899),
      icon: HeroIcons.bookOpen,
    ),
    // Withdrawn
    const _CourseItem(
      type: 'Science & Logic',
      title: 'Organic Chemistry',
      instructor: 'Dr. Marie Curie',
      progress: 15,
      accentColor: Color(0xFFEF4444),
      icon: HeroIcons.beaker,
      withdrawn: true,
    ),
    const _CourseItem(
      type: 'Technology',
      title: 'Data Structures & Algorithms',
      instructor: 'Prof. Donald Knuth',
      progress: 30,
      accentColor: Color(0xFF64748B),
      icon: HeroIcons.cpuChip,
      withdrawn: true,
    ),
  ];

  List<_CourseItem> get _filteredCourses {
    switch (_selectedFilter) {
      case 1:
        return _allCourses.where((c) => !c.withdrawn && c.progress == 100).toList();
      case 2:
        return _allCourses.where((c) => c.withdrawn).toList();
      default:
        return _allCourses.where((c) => !c.withdrawn && c.progress < 100).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final courses = _filteredCourses;

    return Scaffold(
      backgroundColor: AppColors.bgTertiary,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: AppColors.bgPrimary,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EducateU',
              style: AppTextStyles.titleLargeEmphasized
                  .copyWith(color: AppColors.textPrimary),
            ),
            HeroIcon(
              HeroIcons.bellAlert,
              size: 24,
              color: AppColors.iconPrimary,
              style: HeroIconStyle.solid,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Academic Portfolio', style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)),
            SizedBox(height: 1.h,),
            Text('My Courses', style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary)),
            SizedBox(height: 2.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search courses...',
                  hintStyle: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textTertiary),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: HeroIcon(
                      HeroIcons.magnifyingGlass,
                      size: 20,
                      color: AppColors.iconSecondary,
                      style: HeroIconStyle.outline,
                    ),
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.5.h),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.30),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  for (int i = 0; i < _filters.length; i++) ...[
                    if (i > 0) const SizedBox(width: 4),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFilter = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: _selectedFilter == i
                                ? AppColors.bgInverse
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(26),
                            boxShadow: _selectedFilter == i
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.10),
                                      blurRadius: 4,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              _filters[i],
                              style: AppTextStyles.labelLarge.copyWith(
                                color: _selectedFilter == i
                                    ? AppColors.textInverse
                                    : AppColors.textSecondary,
                                fontWeight: _selectedFilter == i
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: courses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HeroIcon(
                            HeroIcons.academicCap,
                            size: 48,
                            color: AppColors.iconTertiary,
                            style: HeroIconStyle.outline,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No courses found',
                            style: AppTextStyles.titleMedium
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: courses.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final c = courses[index];
                        return CourseCardWidget(
                          type: c.type,
                          title: c.title,
                          instructor: c.instructor,
                          progress: c.progress,
                          accentColor: c.accentColor,
                          icon: c.icon,
                          nextSession: c.nextSession,
                          withdrawn: c.withdrawn,
                          onTap: () => context.push('/courses/overview', extra: {
                            'title': c.title,
                            'type': c.type,
                            'instructor': c.instructor,
                            'progress': c.progress,
                          }),
                        );
                      },
                    ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
