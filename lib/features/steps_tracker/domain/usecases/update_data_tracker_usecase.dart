import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/steps_tracker_repositories.dart';

class UpdateDataTrackerUseCase {
  final StepsTrackerRepository stepsTrackerRepository;

  UpdateDataTrackerUseCase(this.stepsTrackerRepository);

  Future<Either<Failure, Unit>> call(int steps) async {
    return await stepsTrackerRepository.updateDataTracker(steps);
  }
}
