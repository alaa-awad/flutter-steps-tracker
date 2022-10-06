part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

// all state fot sing up
class SignUpLoadingState extends UserState {}

class SignUpSuccessState extends UserState {}

class SignUpErrorState extends UserState {
  final String error;

  const SignUpErrorState(this.error);
}

//all state for logOut
class LogOutSuccessState extends UserState {}

class LogOutErrorState extends UserState {
  final String error;

  const LogOutErrorState(this.error);
}
