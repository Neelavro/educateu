
import 'package:educateu/core/textstyles.dart';
import 'package:educateu/presentation/profile/widgets/achieve_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../widgets/quick_access_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: HeroIcon(HeroIcons.arrowLeft,size: 24,color: AppColors.iconPrimary,),
        backgroundColor: AppColors.bgPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile Setting",
            style: AppTextStyles.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary)),
            HeroIcon(HeroIcons.bellAlert,size: 24,color: AppColors.iconPrimary,style: HeroIconStyle.solid,),
          ],
        ),
      ),
      body: Container(
        height: 100.h,
          width: 100.w,
          padding: EdgeInsets.all(16),
          color: AppColors.bgTertiary,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.1827, 0.50, 0.8077],
                      colors: [
                        AppColors.primary,
                        Color(0x33FFFFFF), // rgba(255,255,255,0.20)
                        Color(0xFF0580B3),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                  ),
                ),
                SizedBox(height: 1.h,),
                Text("Alex Johnson",
                style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary),),
                SizedBox(height: 1.h,),
                Row(
                  children: [
                    HeroIcon(HeroIcons.academicCap, color: AppColors.iconTertiary, size: 15,),
                    SizedBox(width: 2.w,),
                    Text("Advanced Data Analytics Program",
                      style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textTertiary),),
                  ],
                ),
                // SizedBox(height: 2.h,),
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border(
                //       left: BorderSide(color: AppColors.textInfoPrimary, width: 2), // #2563EB
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.05),
                //         blurRadius: 2,
                //         offset: const Offset(0, 1),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       // your child widgets here, spaced by gap: 16
                //       Text("Outstanding Balance",
                //         style: AppTextStyles.labelMediumEmphasized.copyWith(color: AppColors.textSecondary),),
                //       SizedBox(height: 1.h,),
                //       Text("\$1,250.00",
                //         style: AppTextStyles.displaySmallEmphasized.copyWith(color: AppColors.textPrimary),),
                //       SizedBox(height: 1.h,),
                //       Text("Next payment due: Oct 24, 2024",
                //         style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textInfoPrimary),),
                //       SizedBox(height: 2.h,),
                //       GestureDetector(
                //         child: Container(
                //           alignment: Alignment.center,
                //           height: 40,
                //           width: 100.w,
                //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: AppColors.primary,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Colors.white.withOpacity(0.40),
                //                 offset: const Offset(0, -2),
                //                 blurRadius: 2,
                //                 blurStyle: BlurStyle.inner,
                //               ),
                //             ],
                //           ),
                //           child: Text(
                //             "Pay Now",
                //             style: AppTextStyles.labelLargeEmphasized
                //                 .copyWith(color: AppColors.textInverse),
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                SizedBox(height: 1.5.h,),
                Text("Quick Access",
                  style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.user,title: 'Personal Info',)),
                    SizedBox(width: 4.w,),
                    Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.bellAlert,title: 'Notifications',)),

                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.shieldCheck,title: 'Security',)),
                    SizedBox(width: 4.w,),
                    Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.banknotes,title: 'Payments',)),

                  ],
                ),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.lockClosed,title: 'Privacy',)),
                    SizedBox(width: 4.w,),
                    Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.exclamationCircle,title: 'Help & Support',)),

                  ],
                ),
                SizedBox(height: 2.h,),
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(12),
                //     border: Border(
                //       left: BorderSide(color: AppColors.textWarningPrimary, width: 2), // #2563EB
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black.withOpacity(0.05),
                //         blurRadius: 2,
                //         offset: const Offset(0, 1),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       // your child widgets here, spaced by gap: 16
                //       Text("Achievements",
                //         style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),),
                //       SizedBox(height: 1.5.h,),
                //       AchieveSectionWidget(),
                //
                //     ],
                //   ),
                // ),
                SizedBox(height: 2.h,),
                Text("App Settings",
                  style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary),),
                SizedBox(height: 2.h,),
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.bgPrimary
                  ),
                  child: Row(
                    children: [
                      HeroIcon(HeroIcons.bellSnooze, color: AppColors.iconSecondary,size: 24,),
                      SizedBox(width: 2.w,),
                      Text("Push Notifications",
                        style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textSecondary),),
                      Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _isEnabled = !_isEnabled),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          width: 48,
                          height: 28,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: _isEnabled ? AppColors.textInfoPrimary : AppColors.textTertiary.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 200),
                            alignment: _isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(24),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(12),
                //       color: AppColors.bgErrorPrimary
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       HeroIcon(HeroIcons.arrowRightEndOnRectangle,color:AppColors.textErrorPrimary ,),
                //       SizedBox(width: 1.w,),
                //       Text("Pay Now",
                //         style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textErrorPrimary),),
                //     ],
                //   ),
                // ),
                SizedBox(height: 2.h,),
                Align(
                  alignment: Alignment.center,
                  child: Text("EducateU Version 4.2.0-Alpha",
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),),
                ),
                SizedBox(height: 12.h,),
              ],
            ),
          )
      ),
    );
  }
}
