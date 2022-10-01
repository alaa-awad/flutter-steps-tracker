import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../repositories/steps_tracker_repositories.dart';

class AddDataStepsTrackerUseCase {
  final StepsTrackerRepository stepsTrackerRepository;

  AddDataStepsTrackerUseCase(this.stepsTrackerRepository);

  Future<Either<Failure, Unit>> call(User user) async {
    return await stepsTrackerRepository.addDataTracker(user);
  }
}
