import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizlet/application/login/sign_in_cubit.dart';
import 'package:quizlet/presentation/core/reusable_widgets/buttons.dart';
import 'package:quizlet/presentation/core/reusable_widgets/reusable_widgets.dart';
import 'package:quizlet/presentation/utils/app_error_helper.dart';
import 'package:quizlet/presentation/utils/colors.dart';
import 'package:quizlet/presentation/utils/textstyles.dart';
import 'package:quizlet/presentation/utils/validators.dart';
import '../../core/reusable_widgets/loading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChangePasswordScreen extends StatelessWidget {
  late bool isLoading;
  late bool isFormValid;

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInWithEmailAndPasswordSuccess) {
        } else if (state is SignInWithEmailAndPasswordFailure) {
          AppErrorHelper.showErrorPopUp(
            state,
            context,
          );
        }
      },
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          isLoading = state is SignInWithEmailAndPasswordLoading;
          isFormValid = false;
          // signInCubit.signInWithEmailAndPasswordFormKey.currentState !=
          //         null &&
          //     signInCubit.signInWithEmailAndPasswordFormKey.currentState!
          //         .validate();
          return AppScaffold(
            hasBackButton: true,
            resizeToAvoidBottomInset: true,
            title: AppLocalizations.of(context)!.changePassword,
            body: Form(
              // key: signInCubit.signInWithEmailAndPasswordFormKey,
              // autovalidateMode: signInCubit.autovalidateMode,
              child: SingleChildScrollView(
                child: AppColumn(
                  start: 20,
                  end: 20,
                  children: [
                    const HeightBox(115),
                    PrimaryTextMedium(
                      start: 50,
                      end: 50,
                      text: AppLocalizations.of(context)!.pleaseTypeNewPassword,
                      fontSize: 14,
                      isCenter: true,
                      color: AppColors.secondaryColor,
                    ),
                    const HeightBox(50),
                    AppFormField(
                      text: 'Password',
                      hintext:
                          AppLocalizations.of(context)!.typeYourPasswordHere,
                      controller: TextEditingController(),
                      isPassword: true,
                      validator: AppValidators.validatePassword,
                      icon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.black,
                      ),
                    ),
                    const HeightBox(10),
                    AppFormField(
                      text: 'Confirm Password',
                      hintext: AppLocalizations.of(context)!
                          .typeYourConfirmPasswordHere,
                      controller: TextEditingController(),
                      isPassword: true,
                      validator: AppValidators.validatePassword,
                      icon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.black,
                      ),
                    ),
                    const HeightBox(110),
                    isLoading
                        ? const LoadingWidget()
                        : AppButton(
                            isFilled: true,
                            width: 335,
                            color: isFormValid
                                ? AppColors.mainColor
                                : AppColors.secondaryColor,
                            text: AppLocalizations.of(context)!.submit,
                            hasShadow: true,
                            onPressed: () {}),
                    const HeightBox(15),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
