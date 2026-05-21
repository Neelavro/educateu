
import 'package:educateu/core/colors.dart';
import 'package:educateu/core/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/authentication_provider.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  void _onDigitChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthenticationProvider>();
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
              Color(0xFFFFF7ED),
              Color(0xFFFFF1F2),
              Color(0xFFEFF6FF),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8.h),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
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
                    color: AppColors.bgPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back arrow
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: AppColors.bgBlackSolid,
                        ),
                      ),
                      SizedBox(height: 1.5.h),

                      // Title
                      Center(
                        child: Text(
                          'Account Activation',
                          style: AppTextStyles.headlineMediumEmphasized
                              .copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                      SizedBox(height: 0.8.h),
                      Center(
                        child: Text(
                          'Complete the steps below to activate your\nEducateU account',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelLarge
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                      SizedBox(height: 2.5.h),

                      // Email info banner
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.borderInfo,
                            width: 0.768,
                          ),
                          color: AppColors.bgInfoPrimary,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            HeroIcon(
                              HeroIcons.envelope,
                              color: AppColors.iconInfo,
                              size: 20,
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySmallEmphasized
                                      .copyWith(color: AppColors.textInfoPrimary),
                                  children: [
                                    const TextSpan(
                                        text: "We've sent an activation code to "),
                                    TextSpan(
                                      text: widget.email,
                                      style: AppTextStyles.bodySmallEmphasized
                                          .copyWith(
                                        color: AppColors.textInfoPrimary,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const TextSpan(
                                        text:
                                        "\nPlease check your email and enter the code below."),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),

                      // OTP label
                      Text(
                        'Enter 4-Digit Activation Code',
                        style: AppTextStyles.labelLargeEmphasized
                            .copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 1.5.h),

                      // OTP boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 18.w,
                            height: 7.h,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: AppTextStyles.headlineMediumEmphasized
                                  .copyWith(color: AppColors.textPrimary),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: AppColors.bgPrimary,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.borderSecondary,
                                    width: 1.2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                    width: 1.8,
                                  ),
                                ),
                              ),
                              onChanged: (value) => _onDigitChanged(value, index),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 2.h),

                      // Resend row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Didn't receive a code?",
                            style: AppTextStyles.labelMediumEmphasized
                                .copyWith(color: AppColors.textTertiary),
                          ),
                          GestureDetector(
                            onTap: () {
                              // handle resend
                            },
                            child: Text(
                              "Send Again?",
                              style: AppTextStyles.labelMediumEmphasized.copyWith(
                                color: AppColors.bgInfo,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.bgInfo,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3.5.h),

                      // Verify button
                      InkWell(
                        onTap:  provider.isLoading
                            ? null
                            : () async {
                          final otp = _controllers.map((c) => c.text).join();
                          if (otp.length < 4) {
                            provider.showToast(context, 'Please enter the complete 4-digit code', isSuccess: false);
                            return;
                          }

                          await provider.loginOtp(context, {
                            'username': widget.email,
                            'otp': otp,
                          });

                          if (provider.errorMessage == null && context.mounted) {
                            context.go('/explore');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: 100.w,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: const [0.0, 0.68, 0.85, 1.0],
                              colors: [
                                AppColors.primary,
                                AppColors.primary,
                                Color.lerp(AppColors.primary, AppColors.bgInfo, 0.4)!
                                    .withOpacity(0.88),
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
                          child:  provider.isLoading
                              ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              :Text(
                            "Verify & Continue",
                            style: AppTextStyles.labelLargeEmphasized
                                .copyWith(color: AppColors.textInverse),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Security banner (your snippet)
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
                            HeroIcon(HeroIcons.shieldCheck,
                                color: AppColors.iconInfo),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                "For security reasons, you'll receive a password reset link only if this email is associated with an active EducateU account.",
                                style: AppTextStyles.bodySmallEmphasized
                                    .copyWith(color: AppColors.textInfoPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      const Divider(thickness: 0.3),
                      SizedBox(height: 1.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Need help? Contact IT Support at support@university.edu",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.labelMedium
                              .copyWith(color: AppColors.textTertiary),
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "© 2025 EducateU. All rights reserved.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.textTertiary),
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Privacy Policy",
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textTertiary)),
                    const SizedBox(width: 8),
                    Text("•",
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textTertiary)),
                    const SizedBox(width: 8),
                    Text("Terms of Service",
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textTertiary)),
                    const SizedBox(width: 8),
                    Text("•",
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textTertiary)),
                    const SizedBox(width: 8),
                    Text("Accessibility",
                        style: AppTextStyles.bodySmall
                            .copyWith(color: AppColors.textTertiary)),
                  ],
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}