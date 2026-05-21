import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../widget/rounded_text_field_widget.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
            colors: [
              Color(0xFFFFF7ED), // orange-50
              Color(0xFFFFF1F2), // rose-50
              Color(0xFFEFF6FF), // blue-50
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 11.h),
                Image.asset('assets/logo.png', height: 5.7.h),
                SizedBox(height: 2.h,),

                Container(
                  width: 100.w,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    boxShadow: [
                      // left
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        offset: Offset(-4, 0),
                        blurRadius: 6,
                      ),
                      // right
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        offset: Offset(4, 0),
                        blurRadius: 6,
                      ),
                      // bottom
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        offset: Offset(0, 6),
                        blurRadius: 10,
                      ),
                    ],
                    color: AppColors.bgPrimary,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AppColors.bgBlackSolid,
                          ),
                        ),
                      ),
                      Text('Forgot Password?',style: AppTextStyles.headlineMediumEmphasized.copyWith(color: AppColors.textPrimary),),
                      SizedBox(height: 1.h,),
                      Text("Enter your university email and we'll send you a recovery link",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textSecondary),),
                      SizedBox(height: 3.h,),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.borderInfo,
                            width: 0.768,
                          ),
                          color: AppColors.bgInfoPrimary,
                        ),
                        child: Row(
                          children: [
                            HeroIcon(HeroIcons.shieldCheck,color: AppColors.iconInfo,),
                            SizedBox(width: 3.w,),
                            Expanded(
                              child: Text("For security reasons, you'll receive a password reset link only if this email is associated with an active EducateU account.",
                                style: AppTextStyles.bodySmallEmphasized.copyWith(color: AppColors.textInfoPrimary),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'University Email',
                            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)

                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      RoundedTextField(
                        controller: emailController,
                        backgroundColor: AppColors.bgTertiary,
                        hintText: "Enter your email",
                        icon: HeroIcons.envelope,
                        iconColor: AppColors.iconTertiary,
                        textColor: AppColors.textTertiary,
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(height: 4.h,),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 100.w,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: const [0.0, 0.68, 0.85, 1.0],
                            colors: [
                              AppColors.primary,
                              AppColors.primary,
                              Color.lerp(AppColors.primary, AppColors.bgInfo, 0.4)!.withOpacity(0.88),
                              AppColors.bgInfo.withOpacity(0.80),
                            ],
                            transform: const GradientRotation(-0.3), // slight diagonal tilt on the blend
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.40),
                              offset: const Offset(0, -2),
                              blurRadius: 2,
                              blurStyle: BlurStyle.inner,
                            ),
                          ],
                        ),
                        child: Text("Send Recovery Link",style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textInverse),),
                      ),
                      SizedBox(height: 3.h,),
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.bgSecondary
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Need additional help?",style: AppTextStyles.labelMediumEmphasized.copyWith(color: AppColors.textTertiary),),
                            SizedBox(height: 1.h,),
                            Row(
                              children: [
                                HeroIcon(HeroIcons.questionMarkCircle,color: AppColors.iconTertiary,),
                                SizedBox(width: 3.w,),
                                Expanded(
                                  child: Text("If you don't have access to your email or continue to have issues, please contact IT Support.",
                                    style: AppTextStyles.bodySmallEmphasized.copyWith(color: AppColors.textTertiary),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),

                      ),
                      SizedBox(height: 3.h,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text:  TextSpan(
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
                            children: [
                              TextSpan(text: "Contact IT Support: "),

                              TextSpan(
                                text: "support@university.edu",
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textInfoPrimary),

                              ),

                              TextSpan(text: " or \nCall "),

                              TextSpan(
                                text: "+1 (555) 123-4567",
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textInfoPrimary),

                              ),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
