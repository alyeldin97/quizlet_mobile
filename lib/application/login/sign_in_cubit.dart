import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/models/user.dart';
import '../../domain/repos/sign_in/sign_in_repo.dart';
import '../../helpers/app_global_data.dart';
import '../../helpers/failures.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInRepo signInRepo;

  SignInCubit(
    this.signInRepo,
  ) : super(SignInInitial());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> signInWithEmailAndPasswordFormKey =
      GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  bool rememberMe = false;

  void signInWithEmailAndPassword() async {
    emit(SignInWithEmailAndPasswordLoading());
    Either<Failure, UserModel> customerOrFailure =
        await signInRepo.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
            cache: rememberMe);
    print(emailController.text);
    print(passwordController.text);

    customerOrFailure.fold(
        (failure) => emit(SignInWithEmailAndPasswordFailure(failure: failure)),
        (user) async {
      AppGlobalData.CURRENT_USER = user;
      emit(SignInWithEmailAndPasswordSuccess());
      _clearFormFields();
    });
  }

  void _clearFormFields() {
    emailController.clear();
    passwordController.clear();
    emit(SignInInitial());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }

  void startValidating() {
    autoValidateMode = AutovalidateMode.always;
    emit(SignInStartValidating());
  }

  void setRememberMe(rememberMe) {
    this.rememberMe = rememberMe;
    emit(SignInToggleRememberMe(rememberMe));
  }
}
