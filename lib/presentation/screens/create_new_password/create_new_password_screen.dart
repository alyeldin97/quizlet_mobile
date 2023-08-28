import 'package:flutter/material.dart';

import '../../core/reusable_widgets/buttons.dart';
import '../../core/reusable_widgets/padding.dart';
import '../../core/reusable_widgets/reusable_widgets.dart';
import '../../utils/colors.dart';
import '../../utils/textstyles.dart';
import '../../utils/validators.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isFormValid = true;
    return AppScaffold(
        body: PaddingHorizontal(
          value: 16,
          child: AppColumn(children: [
            const HeightBox(365),
            PrimaryTextSemiBold(text: 'Create New Password', fontSize: 20),
            const HeightBox(60),
            PrimaryTextRegular(
              text:
                  'Your New Password Must Be Different from Previously Used Password.',
              fontSize: 14,
              isCenter: true,
            ),
            const HeightBox(22),
            AppFormField(
              text: 'Password',
              hintext: 'Type your password here',
              controller: TextEditingController(),
              isPassword: true,
              validator: AppValidators.validatePassword,
            ),
            const HeightBox(10),
            AppFormField(
              text: 'Password',
              hintext: 'Type your password here',
              controller: TextEditingController(),
              isPassword: true,
              validator: AppValidators.validatePassword,
            ),
            const HeightBox(16),
            AppButton(
                isFilled: true,
                width: 335,
                color: isFormValid
                    ? AppColors.mainColor
                    : AppColors.secondaryColor,
                text: 'Save',
                hasShadow: true,
                onPressed: () {
                  // navigateToVerifyEmailScreen(context);
                }),
          ]),
        ),
        title: '');
  }
}
