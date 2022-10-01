import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/reward.dart';
import '../repositories/steps_tracker_repositories.dart';

class GetRewardsUseCase {
  final StepsTrackerRepository stepsTrackerRepository;

  GetRewardsUseCase(this.stepsTrackerRepository);

  Future<Either<Failure, List<Reward>>> call() async {
    return await stepsTrackerRepository.getRewards();
  }
}
