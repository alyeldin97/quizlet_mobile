part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserSuccess extends UserState {}

class UserFailure extends UserState {
  Failure failure;
  UserFailure({
    required this.failure,
  });
}
class RefreshAccessTokenLoading extends UserState {}
class RefreshAccessTokenSuccess extends UserState {}

class RefreshAccessTokenFailure extends UserState {
  Failure failure;
  RefreshAccessTokenFailure({
    required this.failure,
  });
}
class LogOutUserLoading extends UserState {}
class LogOutUserSuccess extends UserState {}

class LogOutUserFailure extends UserState {
  Failure failure;
  LogOutUserFailure({
    required this.failure,
  });
}
