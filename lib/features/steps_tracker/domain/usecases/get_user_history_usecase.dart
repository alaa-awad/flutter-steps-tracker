import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/history.dart';
import '../../../../core/error/failures.dart';
import '../repositories/steps_tracker_repositories.dart';

class GetUserHistoryUseCase {
  final StepsTrackerRepository stepsTrackerRepository;

  GetUserHistoryUseCase(this.stepsTrackerRepository);

  Future<Either<Failure, List<History>>> call() async {
    return await stepsTrackerRepository.getUserHistory();
  }
}
