import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizlet/presentation/core/reusable_widgets/padding.dart';
import 'package:quizlet/presentation/core/reusable_widgets/reusable_widgets.dart';
import 'package:quizlet/presentation/utils/colors.dart';
import 'package:quizlet/presentation/utils/navigators.dart';
import 'package:quizlet/presentation/utils/routes.dart';
import 'package:quizlet/presentation/utils/textstyles.dart';

import '../../core/reusable_widgets/buttons.dart';
import '../../utils/validators.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFormValid = true;
    return AppScaffold(
        body: PaddingHorizontal(
          value: 16,
          child: AppColumn(children: [
            const HeightBox(365),
            const PrimaryTextSemiBold(text: 'Reset my password', fontSize: 20),
            const HeightBox(35),
            Container(
              width: 280.h,
              child: const PrimaryTextMedium(
                  text:
                      '''Enter the email associated with your account and we'll send an email with instructions to reset your password.''',
                  fontSize: 13),
            ),
            const HeightBox(62),
            AppFormField(
              text: 'Email',
              hintext: 'Type your email here',
              controller: TextEditingController(),
              validator: AppValidators.validateEmail,
              icon: const Icon(
                Icons.person,
                color: AppColors.mainColor,
              ),
            ),
            const HeightBox(55),
            AppButton(
                isFilled: true,
                width: 335,
                color: isFormValid
                    ? AppColors.mainColor
                    : AppColors.secondaryColor,
                text: 'Continue',
                hasShadow: true,
                onPressed: () {
                  // navigateToVerifyEmailScreen(context);
                })
          ]),
        ),
        title: '');
  }

  // void navigateToVerifyEmailScreen(context) {
  //   AppNavigator.navigateToRoute(Routes.verifyEmail, context);
  // }
}
