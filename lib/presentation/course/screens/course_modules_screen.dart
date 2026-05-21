import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../widgets/module_card_widget.dart';

class CourseModulesTab extends StatefulWidget {
  const CourseModulesTab({super.key});

  @override
  State<CourseModulesTab> createState() => _CourseModulesTabState();
}

class _CourseModulesTabState extends State<CourseModulesTab> {
  final List<Module> _modules = [
    Module(
      number: 1,
      title: 'System Architecture',
      status: ModuleStatus.completed,
      isDownloaded: true,
    ),
    Module(
      number: 2,
      title: 'Design Patterns',
      status: ModuleStatus.inProgress,
    ),
    Module(
      number: 3,
      title: 'Quality Assurance',
      status: ModuleStatus.locked,
      lockedMessage: 'Complete Module 2 to unlock this content',
    ),
  ];

  void _toggleDownload(Module module, bool value) {
    setState(() => module.isDownloaded = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 2.h, 20, 15.h),
      child: Column(
        children: _modules
            .map(
              (m) => Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: ModuleCard(
                  module: m,
                  onDownloadToggle: (v) => _toggleDownload(m, v),
                  onResume: () {},
                  onRedownload: () {},
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
