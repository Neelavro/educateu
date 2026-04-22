import 'package:educateu/core/textstyles.dart';
import 'package:educateu/presentation/profile/widgets/achieve_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../providers/profile_provider.dart';
import '../widgets/academic_info_widget.dart';
import '../widgets/quick_access_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        leading: HeroIcon(HeroIcons.arrowLeft, size: 24, color: AppColors.iconPrimary),
        backgroundColor: AppColors.bgPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile Setting",
                style: AppTextStyles.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary)),
            HeroIcon(HeroIcons.bellAlert, size: 24, color: AppColors.iconPrimary, style: HeroIconStyle.solid),
          ],
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeroIcon(HeroIcons.exclamationCircle, size: 48, color: AppColors.textErrorPrimary),
                  SizedBox(height: 2.h),
                  Text(
                    provider.errorMessage!,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textErrorPrimary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  GestureDetector(
                    onTap: () => provider.getProfile(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Retry",
                        style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textInverse),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final profile = provider.profile;

          return Container(
            height: 100.h,
            width: 100.w,
            padding: const EdgeInsets.all(16),
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
                        stops: const [0.1827, 0.50, 0.8077],
                        colors: [
                          AppColors.primary,
                          const Color(0x33FFFFFF),
                          const Color(0xFF0580B3),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: CircleAvatar(
                        backgroundImage: profile?.photoPath != null
                            ? NetworkImage(profile!.photoPath!) as ImageProvider
                            : const AssetImage('assets/avatar.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    profile?.fullName ?? '—',
                    style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary),
                  ),
                  SizedBox(height: 1.h),
                  AcademicInfoRow(academicInfo: profile?.academicInfo),
                  SizedBox(height: 1.5.h),
                  Text("Quick Access",
                      style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary)),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          context.push('/profile/personal-info', extra: provider).then((value)async{
                            await provider.getProfile();
                          });
                        },
                          child: QuickAccessButtonWidget(icon: HeroIcons.user, title: 'Personal Info'))),
                      SizedBox(width: 4.w),
                      Expanded(child: InkWell(
                        onTap: (){
                          context.push('/profile/notifications');
                        },
                          child: QuickAccessButtonWidget(icon: HeroIcons.bellAlert, title: 'Notifications'))),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          context.push('/profile/security', extra: provider).then((value)async{
                            await provider.getProfile();
                          });
                        },
                          child: QuickAccessButtonWidget(icon: HeroIcons.shieldCheck, title: 'Security'))),
                      SizedBox(width: 4.w),
                      Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.banknotes, title: 'Payments')),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          context.push('/profile/privacy');

                        },
                          child: QuickAccessButtonWidget(icon: HeroIcons.lockClosed, title: 'Privacy'))),
                      SizedBox(width: 4.w),
                      Expanded(child: QuickAccessButtonWidget(icon: HeroIcons.exclamationCircle, title: 'Help & Support')),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text("App Settings",
                      style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary)),
                  SizedBox(height: 2.h),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.bgPrimary,
                    ),
                    child: Row(
                      children: [
                        HeroIcon(HeroIcons.bellSnooze, color: AppColors.iconSecondary, size: 24),
                        SizedBox(width: 2.w),
                        Text("Push Notifications",
                            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textSecondary)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _isEnabled = !_isEnabled),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: 48,
                            height: 28,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: _isEnabled
                                  ? AppColors.textInfoPrimary
                                  : AppColors.textTertiary.withOpacity(0.25),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "EducateU Version 4.2.0-Alpha",
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}