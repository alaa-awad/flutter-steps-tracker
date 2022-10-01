

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../entities/history.dart';
import '../entities/reward.dart';

abstract class StepsTrackerRepository {
  Future<Either<Failure, User>> getDataTracker();
  Future<Either<Failure, Unit>> addDataTracker(User user);
  Future<Either<Failure, Unit>> updateDataTracker(int steps);
  Future<Either<Failure, List<Reward>>> getRewards();
  Future<Either<Failure, List<History>>> getUserHistory();
  Future<Either<Failure, Unit>> addUserHistory(History history);
}
