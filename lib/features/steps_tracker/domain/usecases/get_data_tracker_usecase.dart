import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../repositories/steps_tracker_repositories.dart';

class GetDataStepsTrackerUseCase {
  final StepsTrackerRepository stepsTrackerRepository;

  GetDataStepsTrackerUseCase(this.stepsTrackerRepository);

  Future<Either<Failure, User>> call() async {
    return await stepsTrackerRepository.getDataTracker();
  }
}
