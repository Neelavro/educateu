import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import 'course_materials_screen.dart';
import 'course_modules_screen.dart';
import 'course_overview_screen.dart';
import 'course_videos_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({
    super.key,
    required this.title,
    required this.type,
    required this.instructor,
    required this.progress,
  });

  final String title;
  final String type;
  final String instructor;
  final int progress;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _currentTab = 0;

  static const _tabs = ['Overview', 'Modules', 'Materials', 'Videos'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) return;
      setState(() => _currentTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgTertiary,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.bgTertiary,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: AppTextStyles.headlineLargeEmphasized.copyWith(
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'EducateU Academic • Winter 2026',
                    style: AppTextStyles.bodyLarge
                        .copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: _currentTab == 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildProgressCard(),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const SizedBox(height: 0),
                  ),
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: AppTextStyles.titleMediumEmphasized,
                    unselectedLabelStyle: AppTextStyles.titleMedium,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 2.5,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.only(right: 28),
                    tabs: _tabs.map((t) => Tab(text: t)).toList(),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            if (_currentTab == 0) CourseOverviewTab(instructor: widget.instructor),
            if (_currentTab == 1) const CourseModulesTab(),
            if (_currentTab == 2) const CourseMaterialsTab(),
            if (_currentTab == 3) const CourseVideosTab(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: AppColors.bgPrimary,
      leading: IconButton(
        icon: const HeroIcon(
          HeroIcons.arrowLeft,
          size: 22,
          color: AppColors.iconPrimary,
          style: HeroIconStyle.outline,
        ),
        onPressed: () => context.pop(),
      ),
      titleSpacing: 0,
      title: Text(
        'Course Overview',
        style: AppTextStyles.titleMediumEmphasized
            .copyWith(color: AppColors.textPrimary),
      ),
      actions: const [
        HeroIcon(
          HeroIcons.bellAlert,
          size: 24,
          color: AppColors.iconPrimary,
          style: HeroIconStyle.solid,
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildProgressCard() {
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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Progress',
                      style: AppTextStyles.labelLarge
                          .copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${widget.progress}% Complete',
                      style: AppTextStyles.headlineSmallEmphasized
                          .copyWith(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ),
              _buildProgressRing(widget.progress / 100),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.play_circle_fill, size: 22),
              label: Text(
                'Continue Learning',
                style: AppTextStyles.titleMediumEmphasized
                    .copyWith(color: AppColors.textInverse),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRing(double value) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 4,
            backgroundColor: AppColors.borderPrimary,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          const Icon(Icons.auto_awesome, size: 18, color: AppColors.primary),
        ],
      ),
    );
  }
}
