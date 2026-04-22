import 'package:flutter/material.dart';
import 'package:educateu/core/textstyles.dart';
import 'package:go_router/go_router.dart';

import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/colors.dart';
import '../../../providers/profile_provider.dart';
import '../../authentication/widget/rounded_text_field_widget.dart';
import '../widgets/academic_details_widget.dart';
import '../widgets/academic_info_widget.dart';
import '../widgets/quick_access_button_widget.dart';


class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumber.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
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
            Text("Personal Info",
                style: AppTextStyles.bodyLargeEmphasized.copyWith(color: AppColors.textPrimary)),
            SizedBox()
          ],
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {

          final profile = provider.profile;
          firstNameController.text = profile!.firstName;
          lastNameController.text = profile!.lastName;
          phoneNumber.text = profile!.mobile;
          addressController.text = profile!.address;

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
                  Text("Basic Information",
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
                          controller: firstNameController,
                          backgroundColor: AppColors.bgTertiary,
                          hintText: "First Name",
                          icon: null,
                          iconColor: AppColors.iconTertiary,
                          textColor: AppColors.textTertiary,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        SizedBox(height: 2.h,),

                        RoundedTextField(
                          controller: lastNameController,
                          backgroundColor: AppColors.bgTertiary,
                          hintText: "Last Name",
                          icon: null,
                          iconColor: AppColors.iconTertiary,
                          textColor: AppColors.textTertiary,
                          onChanged: (value) {
                            print(value);
                          },
                        ),

                        SizedBox(height: 2.h,),

                        RoundedTextField(
                          controller: phoneNumber,
                          backgroundColor: AppColors.bgTertiary,
                          hintText: "Enter your phone number",
                          icon: HeroIcons.phone,
                          iconColor: AppColors.iconTertiary,
                          textColor: AppColors.textTertiary,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        SizedBox(height: 2.h,),

                        RoundedTextField(
                          controller: addressController,
                          backgroundColor: AppColors.bgTertiary,
                          hintText: "Address",
                          icon: HeroIcons.mapPin,
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
                  Text("Academic Details",
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
                      color: AppColors.bgTertiary,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Degree Courses',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                        ),
                        SizedBox(height: 2.h),
                        for(int i = 0; i < profile!.academicInfo.length; i++ )...[
                          AcademicDetailsWidget('', profile!.academicInfo[i]),
                          SizedBox(height: 2.h,),
                        ]


                      ],
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  GestureDetector(
                    onTap: ()async{
                      Map<String, dynamic> payload ={
                        "firstName": firstNameController.text,
                        "lastName": lastNameController.text,
                        "mobile": phoneNumber.text,
                        "address": addressController.text,
                      };

                      await provider.updateProfile(context, payload);

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
                      child:provider.isLoading
                          ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          :Row(
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
