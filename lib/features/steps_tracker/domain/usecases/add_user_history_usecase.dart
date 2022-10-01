import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/history.dart';
import '../repositories/steps_tracker_repositories.dart';

class AddHistoryStepsTrackerUseCase {
  final StepsTrackerRepository stepsTrackerRepository;

  AddHistoryStepsTrackerUseCase(this.stepsTrackerRepository);

  Future<Either<Failure, Unit>> call(History history) async {
    return await stepsTrackerRepository.addUserHistory(history);
  }
}
