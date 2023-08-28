import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizlet/application/sign_up/sign_up_cubit.dart';
import 'package:quizlet/presentation/core/reusable_widgets/buttons.dart';
import 'package:quizlet/presentation/core/reusable_widgets/reusable_widgets.dart';
import 'package:quizlet/presentation/utils/app_error_helper.dart';
import 'package:quizlet/presentation/utils/colors.dart';
import 'package:quizlet/presentation/utils/textstyles.dart';
import 'package:quizlet/presentation/utils/validators.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../core/reusable_widgets/loading.dart';
import '../../utils/navigators.dart';
import '../../utils/routes.dart';

class SignUpScreen extends StatelessWidget {
  // late SignUpCubit signUpCubit;
  late bool isLoading;
  late bool isFormValid;

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    isLoading = false;
    isFormValid = false;
    String countryCode = "";
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpWithEmailAndPasswordSuccess) {
        } else if (state is SignUpWithEmailAndPasswordFailure) {
          print(state.failure);
          AppErrorHelper.showErrorPopUp(
            state,
            context,
          );
        }
      },
      builder: (context, state) {
        SignUpCubit cubit = SignUpCubit.get(context);
        // signUpCubit = BlocProvider.of<SignUpCubit>(context);
        isLoading = state is SignUpWithEmailAndPasswordLoading;
        isFormValid = cubit.formKey.currentState != null &&
            cubit.formKey.currentState!.validate();
        return AppScaffold(
          resizeToAvoidBottomInset: true,
          title: AppLocalizations.of(context)!.signUp,
          body: Form(
            key: cubit.formKey,
            autovalidateMode: cubit.autoValidateMode,
            child: SingleChildScrollView(
              child: AppColumn(
                start: 20,
                end: 20,
                children: [
                  const HeightBox(10),
                  AppFormField(
                    text: 'Name',
                    hintext:
                        AppLocalizations.of(context)!.typeYourFirstNameHere,
                    controller: cubit.firstNameController,
                    validator: AppValidators.validateName,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.black,
                    ),
                  ),
                  const HeightBox(20),
                  AppFormField(
                    text: 'Name',
                    hintext: AppLocalizations.of(context)!.typeYourLastNameHere,
                    controller: cubit.lastNameController,
                    validator: AppValidators.validateName,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.black,
                    ),
                  ),
                  const HeightBox(20),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: AppFormField(
                            text: 'Phone',
                            hintext:
                                AppLocalizations.of(context)!.typeYourPhoneHere,
                            controller: cubit.mobileNumberController,
                            validator: AppValidators.validatePhoneNumber,
                            keyboardType: TextInputType.phone,
                            icon: CountryCodePicker(
                              padding: EdgeInsets.zero,
                              boxDecoration: BoxDecoration(),
                              onChanged: (CountryCode code) {
                                countryCode = code.code ?? "";
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'IT',
                              favorite: ['+39', 'FR', '+20'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HeightBox(20),
                  AppFormField(
                    keyboardType: TextInputType.emailAddress,
                    text: 'Email',
                    hintext: AppLocalizations.of(context)!.typeYourEmailHere,
                    controller: cubit.emailController,
                    validator: AppValidators.validateEmail,
                    icon: const Icon(
                      Icons.mail_outline,
                      color: AppColors.black,
                    ),
                  ),
                  const HeightBox(20),
                  AppFormField(
                    text: 'Password',
                    hintext: AppLocalizations.of(context)!.typeYourPasswordHere,
                    controller: cubit.passwordController,
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                    icon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.black,
                    ),
                  ),
                  const HeightBox(55),
                  state is SignUpWithEmailAndPasswordLoading
                      ? const LoadingWidget()
                      : AppButton(
                          isFilled: true,
                          width: 335,
                          color: isFormValid
                              ? AppColors.mainColor
                              : AppColors.secondaryColor,
                          text: AppLocalizations.of(context)!.signUp,
                          hasShadow: true,
                          onPressed: () {
                            signUp(cubit, countryCode);
                          }),
                  const HeightBox(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryTextLight(
                          text: AppLocalizations.of(context)!
                              .alreadyHaveAnAccount,
                          fontSize: 12),
                      TextButton(
                          onPressed: () {
                            AppNavigator.navigateToRouteReplacement(
                                Routes.signIn, context);
                          },
                          child: PrimaryTextBold(
                            text: AppLocalizations.of(context)!.signIn,
                            fontSize: 12,
                            color: AppColors.mainColor,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const AppSeparator(
                        width: 108,
                        color: AppColors.black,
                      ),
                      PrimaryTextRegular(
                          text: AppLocalizations.of(context)!.or, fontSize: 12),
                      const AppSeparator(
                        width: 108,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  const HeightBox(30),
                  SocialLoginButton(
                    text: AppLocalizations.of(context)!.signInWithGoogle,
                    buttonType: SocialLoginButtonType.google,
                    onPressed: () {},
                    imageWidth: 20,
                    width: double.infinity,
                    height: 38.h,
                  ),
                  const HeightBox(20),
                  SocialLoginButton(
                    buttonType: SocialLoginButtonType.facebook,
                    text: AppLocalizations.of(context)!.signInWithGoogle,
                    onPressed: () {},
                    width: double.infinity,
                    imageWidth: 20,
                    height: 38.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToSignUpScreen(context) {
    AppNavigator.navigateToRoute(Routes.signUp, context);
  }

  void signUp(SignUpCubit signUpCubit, String countryCode) {
    if (isFormValid) {
      signUpCubit.signUp(countryCode);
    } else {
      signUpCubit.startValidating();
    }
  }
}
