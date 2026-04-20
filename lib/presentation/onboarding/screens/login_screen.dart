import 'package:educateu/core/colors.dart';
import 'package:educateu/core/textstyles.dart';
import 'package:educateu/presentation/onboarding/widget/rounded_check_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/authentication_provider.dart';
import '../widget/rounded_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<void> _login(BuildContext context) async {
    final provider = context.read<AuthenticationProvider>();

    await provider.login({
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    });

    if (!mounted) return;

    if (provider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage!)),
      );
    } else {
      if(provider.student!.isTemporaryPassword){
        context.push("/account-activate");
      }
      if(provider.student!.mfaEnabled)
        context.push("/otp");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthenticationProvider>().isLoading;

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
                SizedBox(height: 1.h,),
                Text(
                  'Welcome to EducateU',
                  style: AppTextStyles.headlineMediumEmphasized.copyWith(color: AppColors.textPrimary)
                ),
                SizedBox(height: 0.5.h,),
                Text(
                  'Sign in to access your learning portal',
                  style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)
                ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign in',
                          style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)

                      ),
                      SizedBox(height: 0.5.h,),
                      Text(
                        'Enter your credentials to continue',
                          style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)

                      ),
                      SizedBox(height: 4.h,),
                      Text(
                        'Email',
                          style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)

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

                      SizedBox(height: 1.h,),
                      Text(
                        'Password',
                          style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)
                      ),
                      SizedBox(height: 0.5.h,),

                      RoundedTextField(
                        controller: passwordController,
                        backgroundColor: AppColors.bgTertiary,
                        hintText: "Enter your password",
                        obscureText: true,
                        icon: HeroIcons.lockClosed,
                        suffixIcon: HeroIcons.eye,
                        iconColor: AppColors.iconTertiary,
                        textColor: AppColors.textTertiary,
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              RoundedCheckbox(
                                borderColor: AppColors.borderSecondary,
                                value: isChecked,
                                onChanged: (val) {
                                  setState(() {
                                    isChecked = val!;
                                  });
                                },
                              ),
                              SizedBox(width: 1.5.w,),
                              Text("Remember me", style: AppTextStyles.labelMediumEmphasized.copyWith(color: AppColors.textTertiary),)
                            ],
                          ),
                          //Forgot password?
                          InkWell(
                            onTap: (){
                              context.push("/forgot-password");
                            },
                              child: Text("Forgot password?", style: AppTextStyles.labelMediumEmphasized.copyWith(color: AppColors.textPrimary),))
                        ],
                      ),
                      SizedBox(height: 3.5.h,),
                      GestureDetector(
                        onTap: isLoading ? null : () => _login(context),
                        child: Container(
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
                              transform: const GradientRotation(-0.3),
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
                          child: isLoading
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            "Sign In",
                            style: AppTextStyles.labelLargeEmphasized
                                .copyWith(color: AppColors.textInverse),
                          ),
                        ),
                      ),
                      SizedBox(height:2.h,),

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
                              child: Text('Your connection is secure. We use industry-standard encryption to protect your data.',
                                style: AppTextStyles.bodySmallEmphasized.copyWith(color: AppColors.textInfoPrimary),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height:2.h,),
                      Divider(thickness: 0.3,),
                      SizedBox(height:1.h,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Need help? Contact IT Support at support@university.edu",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelMedium.copyWith(color: AppColors.textTertiary),
                        ),
                      ),
                      SizedBox(height:1.h,),
                    ],
                  ),
                ),
                SizedBox(height:2.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("© 2025 EducateU. All rights reserved.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
                  ),
                ),
                SizedBox(height:1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text("Privacy Policy", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
                    SizedBox(width: 8),
                    Text("•", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),),
                    SizedBox(width: 8),
                    Text("Terms of Service", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),),
                    SizedBox(width: 8),
                    Text("•", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),),
                    SizedBox(width: 8),
                    Text("Accessibility", style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
