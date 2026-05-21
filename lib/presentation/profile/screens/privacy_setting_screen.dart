
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../widgets/toggle_info_widget.dart';

class PrivacySettingScreen extends StatefulWidget {
  const PrivacySettingScreen({super.key});

  @override
  State<PrivacySettingScreen> createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
  final List<Map<String, dynamic>> _privacy = [
    {
      'title': 'Profile Visibility',
      'value': 'Make my profile visible to other students.',
      'isEnabled': true,
    },
    {
      'title': 'Assignment Reminders',
      'value': 'Allow others to see my university email address.',
      'isEnabled': true,
    },
    {
      'title': 'Activity Visibility',
      'value': 'Share my course progress and activity on the community board.',
      'isEnabled': true,
    },
    {
      'title': 'Notification Privacy',
      'value': 'Hide notification content on the lock screen.',
      'isEnabled': true,
    },
    {
      'title': 'Search Visibility',
      'value': 'Updates on tuition balances and due dates.',
      'isEnabled': false,
    },
    {
      'title': 'Support Updates',
      'value': 'Allow my profile to appear in the school search directory.',
      'isEnabled': false,
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
              Text("Privacy",
                  style: AppTextStyles.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary)),
             SizedBox()
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
                  "Privacy Settings",
                  style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary),
                ),
                SizedBox(height: 1.h,),
                Text(
                  "Manage how your information is shared within the student portal.",
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
                    itemCount: _privacy.length,
                    separatorBuilder: (_, __) => Divider(color: AppColors.borderPrimary, height: 1),
                    itemBuilder: (context, index) {
                      final item = _privacy[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ToggleInfoWidget(
                          title: item['title'],
                          value: item['value'],
                          isEnabled: item['isEnabled'],
                          onToggle: () => setState(() {
                            _privacy[index]['isEnabled'] = !item['isEnabled'];
                          }),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  "Changes to your privacy settings may take a few minutes to apply across the platform.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),),
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
