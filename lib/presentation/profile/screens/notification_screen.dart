
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../widgets/toggle_info_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Push Notifications',
      'value': 'Get notified when a new grade is posted.',
      'isEnabled': true,
    },
    {
      'title': 'Assignment Reminders',
      'value': 'Reminders for upcoming due dates (24h/1h before).',
      'isEnabled': true,
    },
    {
      'title': 'Course Announcements',
      'value': 'Updates from your instructors and departments.',
      'isEnabled': true,
    },
    {
      'title': 'New Messages',
      'value': 'Real-time alerts for faculty and peer messages.',
      'isEnabled': true,
    },
    {
      'title': 'Payment Reminders',
      'value': 'Updates on tuition balances and due dates.',
      'isEnabled': false,
    },
    {
      'title': 'Support Updates',
      'value': 'Tracking updates for your help tickets.',
      'isEnabled': false,
    },
    {
      'title': 'Feedback Requests',
      'value': 'Notifications for submitting feedback on courses and services.',
      'isEnabled': true,
    },
    {
      'title': 'Event Notifications',
      'value': 'Details about upcoming campus events and activities.',
      'isEnabled': true,
    },
    {
      'title': 'System Alerts',
      'value': 'Important platform maintenance and security notices.',
      'isEnabled': true,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: InkWell(
            onTap: (){
              context.pop();
            },
            child: HeroIcon(HeroIcons.arrowLeft, size: 24, color: AppColors.iconPrimary)),
        backgroundColor: AppColors.bgPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Notifications",
                style: AppTextStyles.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary)),
            HeroIcon(HeroIcons.bellAlert, size: 24, color: AppColors.iconPrimary, style: HeroIconStyle.solid),
          ],
        ),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: const EdgeInsets.all(16),
        color: AppColors.bgTertiary,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stay Updated",
                style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary),
              ),
              SizedBox(height: 1.h,),
              Text(
                "Choose how and when you want to receive updates from EducateU.",
                style: AppTextStyles.bodySmallEmphasized.copyWith(color: AppColors.textTertiary),
              ),
              SizedBox(height: 2.h,),
              Container(
                width: 100.w,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.bgPrimary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      offset: const Offset(-4, 0),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      offset: const Offset(4, 0),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      offset: const Offset(0, 6),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => Divider(color: AppColors.borderPrimary, height: 1),
                  itemBuilder: (context, index) {
                    final item = _notifications[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ToggleInfoWidget(
                        title: item['title'],
                        value: item['value'],
                        isEnabled: item['isEnabled'],
                        onToggle: () => setState(() {
                          _notifications[index]['isEnabled'] = !item['isEnabled'];
                        }),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 4.h,),
              Container(
                width: 100.w,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeroIcon(HeroIcons.lightBulb, size: 24, color: Color(0xFFE65100)),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        "Focus on what matters. We'll only interrupt when it's essential for your success.",
                        style: AppTextStyles.bodyLargeEmphasized.copyWith(
                          color: AppColors.textWarningPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h,),
              GestureDetector(
                onTap: ()async{
                 context.pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 100.w,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.40),
                        offset: const Offset(0, -2),
                        blurRadius: 2,
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeroIcon(HeroIcons.checkCircle, size: 20,color: AppColors.iconInverse,),
                      SizedBox(width: 2.w),
                      Text(
                        "Save Changes",
                        style: AppTextStyles.labelLargeEmphasized
                            .copyWith(color: AppColors.textInverse),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 12.h,),

            ],
          ),
        ),
      )
    );
  }
}
