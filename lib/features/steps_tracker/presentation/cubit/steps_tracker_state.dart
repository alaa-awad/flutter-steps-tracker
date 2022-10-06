part of 'steps_tracker_cubit.dart';

abstract class StepsTrackerState extends Equatable {
  const StepsTrackerState();

  @override
  List<Object> get props => [];
}

class StepsTrackerInitial extends StepsTrackerState {}

class GetUserLoadingState extends StepsTrackerState {}
class GetUserSuccessState extends StepsTrackerState {}
class GetUserErrorState extends StepsTrackerState {
  final String error;

  const GetUserErrorState(this.error);
}

class UpdateUserLoadingState extends StepsTrackerState {}
class UpdateUserSuccessState extends StepsTrackerState {}
class UpdateUserErrorState extends StepsTrackerState {
  final String error;

  const UpdateUserErrorState(this.error);
}

class ChangeLanguageState extends StepsTrackerState {}
class ChangeThemeState extends StepsTrackerState {}

class AddHistoryLoadingState extends StepsTrackerState {}
class AddHistorySuccessState extends StepsTrackerState {}
class AddHistoryErrorState extends StepsTrackerState {
  final String error;

  const AddHistoryErrorState(this.error);
}

class GetHistoryLoadingState extends StepsTrackerState {}
class GetHistorySuccessState extends StepsTrackerState {}
class GetHistoryErrorState extends StepsTrackerState {
  final String error;

  const GetHistoryErrorState(this.error);
}
