import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/routing/navigate_and_finish.dart';
import '../../../../core/strings/map_failure_to_message.dart';
import '../../domain/usecases/log_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignUpUseCase signUp;
  final LogOutUseCase logOut;
  UserCubit({
    required this.signUp,
    required this.logOut,
  }) : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);


  void signUpCubit({
    required String name,}) async {
    emit(SignUpLoadingState());
    final failureOrDoneMessage =
        await signUp(name: name,);
    failureOrDoneMessage.fold(
        (failure) => emit(SignUpErrorState(mapFailureToMessage(failure))),
        (r) => emit(SignUpSuccessState()));
  }

  void logOutCubit() async{
    final failureOrDoneMessage = await logOut();
    failureOrDoneMessage.fold(
            (failure) => emit(LogOutErrorState(mapFailureToMessage(failure))),
            (r) {
              return emit(LogOutSuccessState());
            });
  }
}
