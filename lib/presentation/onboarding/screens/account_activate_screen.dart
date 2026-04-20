import 'package:educateu/domain/entities/security_question_entity.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../../../providers/authentication_provider.dart';
import '../widget/rounded_check_box_widget.dart';
import '../widget/rounded_drop_down_widget.dart';
import '../widget/rounded_text_field_widget.dart';

class AccountActivateScreen extends StatefulWidget {
  const AccountActivateScreen({super.key});

  @override
  State<AccountActivateScreen> createState() => _AccountActivateScreenState();
}

class _AccountActivateScreenState extends State<AccountActivateScreen> {
  TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  SecurityQuestionEntity? _selectedValue;
  bool isChecked = false;

// Add this method to your state class
  void _validatePassword(String value) {
    setState(() {
      _hasMinLength = value.length >= 8;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasLowercase = value.contains(RegExp(r'[a-z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#\$%\^&\*]'));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthenticationProvider>().getSecurityQuestions();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthenticationProvider>();

    return Scaffold(
      body: provider.isLoading
    ? const SizedBox(

      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 3,
        ),
      ),
    )
        : Container(
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
                SizedBox(height: 7.h),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 5.7.h,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 20, color: AppColors.bgBlackSolid,),
                        Text('Back to Sign in', style: AppTextStyles.bodyMediumEmphasized.copyWith(color: AppColors.bgBlackSolid),)
                      ],
                    ),
                  ),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Account Activation?',style: AppTextStyles.headlineMediumEmphasized.copyWith(color: AppColors.textPrimary),),
                      SizedBox(height: 1.h,),
                      Text("Complete the steps below to activate your EducateU account",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textSecondary),),
                      SizedBox(height: 3.h,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Create Password *',
                            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)
                        ),
                      ),
                      SizedBox(height: 0.5.h,),

                      RoundedTextField(
                        controller: passwordController,
                        backgroundColor: AppColors.bgTertiary,
                        hintText: "e.g., 2021045678",
                        obscureText: true,
                        icon: HeroIcons.lockClosed,
                        suffixIcon: HeroIcons.eye,
                        iconColor: AppColors.iconTertiary,
                        textColor: AppColors.textTertiary,
                        onChanged: (value) {
                          _validatePassword(value);
                        },
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.bgTertiary, // #F1F5F9
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Password must contain:',
                              style: AppTextStyles.labelMediumEmphasized.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildRequirementRow('At least 8 characters', _hasMinLength),
                            _buildRequirementRow('One uppercase letter', _hasUppercase),
                            _buildRequirementRow('One lowercase letter', _hasLowercase),
                            _buildRequirementRow('One number', _hasNumber),
                            _buildRequirementRow('One special character (!@#\$%^&*)', _hasSpecialChar),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Confirm Password *',
                            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)
                        ),
                      ),
                      SizedBox(height: 0.5.h,),

                      RoundedTextField(
                        controller: confirmPasswordController,
                        backgroundColor: AppColors.bgTertiary,
                        hintText: "e.g., 2021045678",
                        obscureText: true,
                        icon: HeroIcons.lockClosed,
                        suffixIcon: HeroIcons.eye,
                        iconColor: AppColors.iconTertiary,
                        textColor: AppColors.textTertiary,
                        onChanged: (value) {
                          setState(() {

                          });
                        },
                      ),
                      SizedBox(height: 1.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Security Question (Optional)',
                            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      RoundedDropdown<SecurityQuestionEntity>(
                        value: _selectedValue,
                        backgroundColor: AppColors.bgTertiary,
                        iconColor: AppColors.iconTertiary,
                        textColor: AppColors.textTertiary,
                        hintText: 'What was the make of your first car?',
                        items: provider.securityQuestions
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.question)))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedValue = value);
                        },
                      ),
                      SizedBox(height: 1.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            'Your Answer',
                            style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textPrimary)
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      RoundedTextField(
                        controller: answerController,
                        backgroundColor: AppColors.bgTertiary,
                        hintText: "e.g.,Tuition",
                        icon: null,

                        iconColor: AppColors.iconTertiary,
                        textColor: AppColors.textTertiary,
                        onChanged: (value) {

                        },
                      ),
                      SizedBox(height: 1.h),
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
                          RichText(
                            text: TextSpan(
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
                              children: [
                                TextSpan(text: "I agree to the "),
                                TextSpan(
                                  text: "Terms of Service",
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textInfoPrimary),
                                ),
                                TextSpan(text: " and "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textInfoPrimary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      InkWell(
                        onTap:provider.isLoading
                            ? null
                            : () {
                          if (!_hasMinLength || !_hasUppercase || !_hasLowercase || !_hasNumber || !_hasSpecialChar) {
                            provider.showToast(context, 'Password does not meet the required criteria', isSuccess: false);
                            return;
                          }

                          if (passwordController.text != confirmPasswordController.text) {
                            provider.showToast(context, 'Passwords do not match', isSuccess: false);
                            return;
                          }

                          if (!isChecked) {
                            provider.showToast(context, 'Please accept the Terms of Service and Privacy Policy', isSuccess: false);
                            return;
                          }

                          final payload = <String, dynamic>{
                            "currentPassword": provider.tempPassword,
                            'newPassword': passwordController.text,
                            'confirmPassword': confirmPasswordController.text,
                          };

                          if (_selectedValue != null && answerController.text.isNotEmpty) {
                            payload['securityQuestionId'] = _selectedValue!.id;
                            payload['securityQuestionAnswer'] = answerController.text;
                          }

                          context.read<AuthenticationProvider>().changePassword(context, payload);
                        },
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
                          child: provider.isLoading
                        ? const SizedBox(
                        height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            :Text("Confirm",style: AppTextStyles.labelLargeEmphasized.copyWith(color: AppColors.textInverse),),
                        ),
                      ),
                    ],

                  ),

                ),
                SizedBox(height: 7.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildRequirementRow(String label, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 18,
            color: isMet ? Colors.green : AppColors.textTertiary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isMet ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
