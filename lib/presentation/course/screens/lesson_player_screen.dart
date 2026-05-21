import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../models/lesson.dart';
import '../models/material.dart';
import '../widgets/comment_tile_widget.dart';
import '../widgets/external_resource_row_widget.dart';
import '../widgets/file_card_widget.dart';
import '../widgets/lesson_row_widget.dart';
import '../widgets/note_card_widget.dart';
import '../widgets/reading_card_widget.dart';

class LessonPlayerScreen extends StatefulWidget {
  const LessonPlayerScreen({super.key});

  @override
  State<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends State<LessonPlayerScreen> {
  int _innerTab = 0;

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _discussionController = TextEditingController();

  static const _innerTabs = ['Video', 'Notes', 'Discussion', 'Resources'];

  static const _videoModules = [
    LessonModule(
      title: 'Module 1: Architecture',
      accentColor: AppColors.primary,
      meta: '3 Videos • 45m',
      lessons: [
        VideoLesson(
          title: 'Microservices Fundamentals',
          duration: '12:45',
          status: LessonStatus.watched,
        ),
        VideoLesson(
          title: 'Scalability & Load Balancing',
          duration: '18:20',
          status: LessonStatus.inProgress,
        ),
        VideoLesson(
          title: 'Advanced Event Sourcing',
          duration: '14:15',
          status: LessonStatus.locked,
        ),
      ],
    ),
    LessonModule(
      title: 'Module 2: Testing & CI/CD',
      accentColor: AppColors.bgWarning,
      meta: '2 Videos • 38m',
      lessons: [
        VideoLesson(
          title: 'Advanced Event Sourcing',
          duration: '14:15',
          status: LessonStatus.locked,
        ),
      ],
    ),
  ];

  static const _notes = [
    LessonNote(
      timestamp: '04:22',
      body:
          'Difference between monolithic and microservices: coupling vs. cohesion.',
      accentColor: AppColors.bgBrand,
    ),
    LessonNote(
      timestamp: '07:15',
      body:
          'Difference between monolithic and microservices: coupling vs. cohesion.',
      accentColor: AppColors.bgWarning,
    ),
    LessonNote(
      timestamp: '11:03',
      body:
          'Difference between monolithic and microservices: coupling vs. cohesion.',
      accentColor: AppColors.bgInfo,
    ),
  ];

  static const _comments = [
    DiscussionComment(
      author: 'Alex Rivera',
      timeAgo: '2 hours ago',
      body:
          'Can someone explain the difference between coupling and cohesion '
          'again? Is it basically just how much code is connected?',
      likes: 12,
      replies: [
        DiscussionComment(
          author: 'Sarah Chen',
          timeAgo: '1 hour ago',
          body:
              'Cohesion is about how focused a single module is (internal), '
              'while coupling is how much modules depend on each other '
              '(external). High cohesion, low coupling is the goal!',
        ),
      ],
    ),
    DiscussionComment(
      author: 'Jordan Park',
      timeAgo: '3 hours ago',
      body:
          'Can someone explain the difference between coupling and cohesion '
          'again? Is it basically just how much code is connected?',
      likes: 12,
    ),
    DiscussionComment(
      author: 'Mia Torres',
      timeAgo: '5 hours ago',
      body:
          'Can someone explain the difference between coupling and cohesion '
          'again? Is it basically just how much code is connected?',
      likes: 12,
    ),
  ];

  static const _fileResources = [
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

  static const _linkResources = [
    ExternalResource(
      title: 'AWS Well-Architected Framework',
      url: 'aws.amazon.com/architecture',
    ),
    ExternalResource(
      title: 'GitHub: Engineering Standards',
      url: 'github.com/engineering',
    ),
  ];

  static const _featuredReading = RequiredReading(
    title: 'Microservices vs. Monoliths: A Comparative Study',
    description:
        'An in-depth analysis of architectural shifts in modern enterprise '
        'software.',
    readTime: '15 MIN READ',
  );

  @override
  void dispose() {
    _noteController.dispose();
    _discussionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 2.h, 20, 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(),
            SizedBox(height: 2.h),
            _buildLessonInfo(),
            SizedBox(height: 2.5.h),
            _buildNavButtons(),
            SizedBox(height: 2.5.h),
            _buildInnerTabs(),
            SizedBox(height: 2.5.h),
            _buildTabBody(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // APP BAR
  // ---------------------------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(72),
      child: Container(
        color: AppColors.bgPrimary,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(4, 0.5.h, 16, 1.h),
            child: Row(
              children: [
                IconButton(
                  icon: const HeroIcon(
                    HeroIcons.arrowLeft,
                    size: 22,
                    color: AppColors.iconPrimary,
                    style: HeroIconStyle.outline,
                  ),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Advanced Software Engineering',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleSmallEmphasized
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 0.75.h),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0.65,
                                minHeight: 6,
                                backgroundColor: AppColors.borderPrimary,
                                valueColor: const AlwaysStoppedAnimation(
                                    AppColors.bgInfo),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            '65% Complete',
                            style: AppTextStyles.labelMediumEmphasized
                                .copyWith(color: AppColors.bgInfo),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
                const HeroIcon(
                  HeroIcons.bellAlert,
                  size: 24,
                  color: AppColors.iconPrimary,
                  style: HeroIconStyle.solid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // VIDEO PLAYER
  // ---------------------------------------------------------------------------
  Widget _buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2A38),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.22),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded,
                    size: 38, color: Colors.white),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 12,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 10.75 / 12.75,
                      minHeight: 4,
                      backgroundColor:
                          Colors.white.withValues(alpha: 0.25),
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.bgInfo),
                    ),
                  ),
                  SizedBox(height: 1.25.h),
                  Row(
                    children: [
                      const Icon(Icons.pause, size: 18, color: Colors.white),
                      SizedBox(width: 2.5.w),
                      Text(
                        '10:45 / 12:45',
                        style: AppTextStyles.labelMediumEmphasized
                            .copyWith(color: Colors.white),
                      ),
                      const Spacer(),
                      _playerIcon(Icons.settings),
                      SizedBox(width: 3.5.w),
                      _playerIcon(Icons.closed_caption),
                      SizedBox(width: 3.5.w),
                      _playerIcon(Icons.fullscreen),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playerIcon(IconData icon) =>
      Icon(icon, size: 19, color: Colors.white.withValues(alpha: 0.9));

  // ---------------------------------------------------------------------------
  // LESSON INFO
  // ---------------------------------------------------------------------------
  Widget _buildLessonInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Module 1: Architecture',
          style: AppTextStyles.labelLargeEmphasized
              .copyWith(color: AppColors.bgInfo),
        ),
        SizedBox(height: 0.75.h),
        Text(
          'Microservices Fundamentals',
          style: AppTextStyles.headlineSmallEmphasized
              .copyWith(color: AppColors.textPrimary),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            const Icon(Icons.access_time,
                size: 16, color: AppColors.textSecondary),
            SizedBox(width: 1.5.w),
            Text(
              'In progress (85% watched)',
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // PREVIOUS / NEXT
  // ---------------------------------------------------------------------------
  Widget _buildNavButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              backgroundColor: AppColors.bgPrimary,
              side: const BorderSide(color: AppColors.borderPrimary),
              padding: EdgeInsets.symmetric(vertical: 1.75.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.chevron_left, size: 20),
                SizedBox(width: 1.w),
                Text('Previous',
                    style: AppTextStyles.titleSmallEmphasized
                        .copyWith(color: AppColors.textPrimary)),
              ],
            ),
          ),
        ),
        SizedBox(width: 3.5.w),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 1.75.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Next Lesson',
                    style: AppTextStyles.titleSmallEmphasized
                        .copyWith(color: AppColors.textInverse)),
                SizedBox(width: 1.w),
                const Icon(Icons.chevron_right, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // INNER TABS (segmented pill)
  // ---------------------------------------------------------------------------
  Widget _buildInnerTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(_innerTabs.length, (i) {
          final selected = i == _innerTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _innerTab = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(vertical: 1.25.h),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.bgSecondary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  _innerTabs[i],
                  textAlign: TextAlign.center,
                  style: selected
                      ? AppTextStyles.labelLargeEmphasized
                          .copyWith(color: AppColors.textPrimary)
                      : AppTextStyles.labelLarge
                          .copyWith(color: AppColors.textSecondary),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabBody() {
    switch (_innerTab) {
      case 0:
        return _buildVideoTab();
      case 1:
        return _buildNotesTab();
      case 2:
        return _buildDiscussionTab();
      case 3:
        return _buildResourcesTab();
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------------------------------------------------------------------------
  // VIDEO TAB
  // ---------------------------------------------------------------------------
  Widget _buildVideoTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final module in _videoModules) ...[
          _buildModuleHeader(module),
          SizedBox(height: 1.75.h),
          for (final lesson in module.lessons) ...[
            LessonRow(lesson: lesson, onTap: () {}),
            SizedBox(height: 1.75.h),
          ],
          SizedBox(height: 1.h),
        ],
      ],
    );
  }

  Widget _buildModuleHeader(LessonModule module) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: module.accentColor,
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
          module.meta,
          style: AppTextStyles.labelSmall
              .copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // NOTES TAB
  // ---------------------------------------------------------------------------
  Widget _buildNotesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNoteComposer(),
        SizedBox(height: 2.5.h),
        for (final note in _notes) ...[
          NoteCard(note: note, onEdit: () {}),
          SizedBox(height: 1.75.h),
        ],
      ],
    );
  }

  Widget _buildNoteComposer() {
    return Container(
      padding: EdgeInsets.all(2.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Take a quick note...',
                style: AppTextStyles.titleSmallEmphasized
                    .copyWith(color: AppColors.textPrimary),
              ),
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.bgSuccess,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 1.5.w),
              Text(
                'Autosaving...',
                style: AppTextStyles.labelMediumEmphasized
                    .copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: 1.75.h),
          Container(
            padding: EdgeInsets.all(1.75.h),
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _noteController,
              maxLines: 2,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textPrimary),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText:
                    'Microservices use lightweight protocols like HTTP or gRPC...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DISCUSSION TAB
  // ---------------------------------------------------------------------------
  Widget _buildDiscussionTab() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.5.h),
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
      child: Column(
        children: [
          for (int i = 0; i < _comments.length; i++) ...[
            CommentTile(comment: _comments[i], onReply: () {}),
            if (i != _comments.length - 1)
              Divider(height: 3.h, color: AppColors.borderPrimary),
          ],
          SizedBox(height: 1.5.h),
          _buildDiscussionComposer(),
        ],
      ),
    );
  }

  Widget _buildDiscussionComposer() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFD8B98C),
          child: Icon(Icons.person, size: 18, color: Colors.white),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _discussionController,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Add to the discussion...',
                      hintStyle: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send_rounded,
                      size: 17, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // RESOURCES TAB
  // ---------------------------------------------------------------------------
  Widget _buildResourcesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final f in _fileResources) ...[
          FileCard(file: f, onDownload: () {}),
          SizedBox(height: 1.5.h),
        ],
        SizedBox(height: 0.5.h),
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
              for (int i = 0; i < _linkResources.length; i++) ...[
                ExternalResourceRow(
                  resource: _linkResources[i],
                  onTap: () {},
                ),
                if (i != _linkResources.length - 1)
                  const Divider(height: 1, color: AppColors.borderPrimary),
              ],
            ],
          ),
        ),
        SizedBox(height: 2.5.h),
        ReadingCard(reading: _featuredReading, onOpen: () {}),
      ],
    );
  }
}
