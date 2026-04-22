

import 'package:educateu/core/helper.dart';
import 'package:educateu/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../core/textstyles.dart';
import '../../../providers/authentication_provider.dart';
import '../../authentication/widget/rounded_text_field_widget.dart';
import '../widgets/toggle_info_widget.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  bool isActive = false;

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
    isActive = currentStudent.value.mfaEnabled;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    currentPasswordController.dispose();
  }


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
              Text("Security",
                  style: AppTextStyles.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary)),
              SizedBox()
            ],
          ),
        ),
        body: Consumer<ProfileProvider>(
            builder: (context, provider, _) {
              final profile = provider.profile;

              return  Container(
                height: 100.h,
                width: 100.w,
                padding: const EdgeInsets.all(16),
                color: AppColors.bgTertiary,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Security Settings",
                        style: AppTextStyles.headlineLargeEmphasized.copyWith(color: AppColors.textPrimary),
                      ),
                      SizedBox(height: 3.h,),
                      Text("Password Management",
                          style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary)),
                      SizedBox(height: 2.h,),
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            RoundedTextField(
                              controller: currentPasswordController,
                              backgroundColor: AppColors.bgTertiary,
                              hintText: "Enter current password",
                              icon: null,
                              obscureText: true,
                              suffixIcon: HeroIcons.eye,
                              iconColor: AppColors.iconTertiary,
                              textColor: AppColors.textTertiary,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            SizedBox(height: 2.h,),

                            RoundedTextField(
                              controller: newPasswordController,
                              backgroundColor: AppColors.bgTertiary,
                              hintText: "Create new password",
                              icon: null,
                              obscureText: true,
                              suffixIcon: HeroIcons.eye,
                              iconColor: AppColors.iconTertiary,
                              textColor: AppColors.textTertiary,
                              onChanged: (value) {
                                _validatePassword(value);
                              },
                            ),

                            SizedBox(height: 2.h),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.bgTertiary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Password must contain:',
                                    style: AppTextStyles.labelMediumEmphasized.copyWith(color: AppColors.textTertiary),
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

                            SizedBox(height: 2.h,),

                            RoundedTextField(
                              controller: confirmPasswordController,
                              backgroundColor: AppColors.bgTertiary,
                              hintText: "Re-type new password",
                              icon: HeroIcons.phone,
                              obscureText: true,
                              suffixIcon: HeroIcons.eye,
                              iconColor: AppColors.iconTertiary,
                              textColor: AppColors.textTertiary,
                              onChanged: (value) {
                                print(value);
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Text("Privacy & Access",
                          style: AppTextStyles.titleMediumEmphasized.copyWith(color: AppColors.textPrimary)),
                      SizedBox(height: 2.h,),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.bgPrimary
                        ),
                        child: ToggleInfoWidget(
                          title: 'Two-Factor Authentication (2FA)',
                          value: 'Secure your account by requiring an additional verification code upon sign-in.',
                          isEnabled: isActive,
                          onToggle: () => setState(() {
                            isActive = !isActive;
                          }),
                        ),
                      ),

                      SizedBox(height: 2.h,),
                      Text(
                        "Please allow a few minutes for the changes to your privacy settings to be implemented across all devices.",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),),
                      SizedBox(height: 4.h,),
                      GestureDetector(
                        onTap: ()async{
                          final authProvider = context.read<AuthenticationProvider>();
                          if (!_hasMinLength || !_hasUppercase || !_hasLowercase || !_hasNumber || !_hasSpecialChar) {
                            provider.showToast(context, 'Password does not meet the required criteria', isSuccess: false);
                            return;
                          }

                          if (newPasswordController.text != confirmPasswordController.text) {
                            provider.showToast(context, 'Passwords do not match', isSuccess: false);
                            return;
                          }
                          final payload = <String, dynamic>{
                            "currentPassword": currentPasswordController.text,
                            'newPassword': newPasswordController.text,
                            'confirmPassword': confirmPasswordController.text,
                          };
                          await authProvider.changePassword(context, payload).then((value)async{
                            await provider.updateProfile(context, {'mfaEnabled': isActive});
                          });


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
              );
            }
        )
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
