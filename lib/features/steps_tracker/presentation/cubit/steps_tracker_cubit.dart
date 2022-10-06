import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/strings/app_string.dart';
import 'package:flutter_steps_tracker/core/var.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/history.dart';

import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/routing/navigate_and_finish.dart';
import '../../../../core/strings/map_failure_to_message.dart';
import '../../../../main.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/usecases/add_data_tracker_usecase.dart';
import '../../domain/usecases/add_user_history_usecase.dart';
import '../../domain/usecases/get_data_tracker_usecase.dart';
import '../../domain/usecases/get_rewards_usecase.dart';
import '../../domain/usecases/get_user_history_usecase.dart';
import '../../domain/usecases/update_data_tracker_usecase.dart';
part 'steps_tracker_state.dart';

class StepsTrackerCubit extends Cubit<StepsTrackerState> {
  StepsTrackerCubit(
      {required this.addDataSteps,
      required this.addHistory,
      required this.getDataSteps,
      required this.getRewards,
      required this.getHistory,
      required this.updateDataTracker})
      : super(StepsTrackerInitial());

  final AddDataStepsTrackerUseCase addDataSteps;
  final AddHistoryStepsTrackerUseCase addHistory;
  final GetDataStepsTrackerUseCase getDataSteps;
  final GetRewardsUseCase getRewards;
  final GetUserHistoryUseCase getHistory;
  final UpdateDataTrackerUseCase updateDataTracker;

  static StepsTrackerCubit get(context) => BlocProvider.of(context);

  void updateData(int steps) async {
    emit(UpdateUserLoadingState());
    final failureOrDoneMessage = await updateDataTracker(steps);
    failureOrDoneMessage.fold(
        (failure) => emit(UpdateUserErrorState(mapFailureToMessage(failure))),
        (r) => emit(UpdateUserSuccessState()));
  }

  void addHistoryCubit(History history) async {
    emit(AddHistoryLoadingState());
    final failureOrDoneMessage = await addHistory(history);
    failureOrDoneMessage.fold(
            (failure) => emit(AddHistoryErrorState(mapFailureToMessage(failure))),
            (r) => emit(AddHistorySuccessState()));
  }

  void getUser() async {
    emit(GetUserLoadingState());
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(AppString.userToken)
        .get()
        .then((value) {
      user = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error.toString()));
    });
  }

   getHistoryCubit() async {
    emit(GetHistoryLoadingState());
    final failureOrDoneMessage = await getHistory();
    failureOrDoneMessage.fold(
            (failure) => emit(GetHistoryErrorState(mapFailureToMessage(failure))),
            (r) => emit(GetHistorySuccessState()));
  }


  void changeLanguage(String value, BuildContext context) {
    CacheHelper.sharedPreferences.setString('language', value);
    navigateAndFinish(context, const MyApp());
  }

  void changeTheme(String value, BuildContext context) {
    CacheHelper.sharedPreferences.setString('theme', value);
    navigateAndFinish(context, const MyApp());
  }

}
