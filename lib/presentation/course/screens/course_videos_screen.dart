import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../models/video.dart';
import '../widgets/video_module_section_widget.dart';

class CourseVideosTab extends StatelessWidget {
  const CourseVideosTab({super.key});

  static const _modules = [
    VideoModule(
      title: 'Module 1: Architecture',
      videoCount: 3,
      duration: '45m',
      accent: AppColors.primary,
      videos: [
        Video(
          title: 'Microservices Fundamentals',
          duration: '12:45',
          status: VideoStatus.watched,
        ),
        Video(
          title: 'Scalability & Load Balancing',
          duration: '18:20',
          status: VideoStatus.inProgress,
        ),
        Video(
          title: 'Advanced Event Sourcing',
          duration: '14:15',
          status: VideoStatus.locked,
        ),
      ],
    ),
    VideoModule(
      title: 'Module 2: Testing & CI/CD',
      videoCount: 2,
      duration: '38m',
      accent: AppColors.bgWarning,
      videos: [
        Video(
          title: 'Advanced Event Sourcing',
          duration: '14:15',
          status: VideoStatus.locked,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h, bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._modules.map((m) => VideoModuleSection(
                module: m,
                onLessonTap: (_) => context.push('/courses/lesson'),
              )),
        ],
      ),
    );
  }
}
