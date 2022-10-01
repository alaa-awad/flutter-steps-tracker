import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_steps_tracker/core/error/failures.dart';
import 'package:flutter_steps_tracker/core/network/network_info.dart';
import 'package:flutter_steps_tracker/features/auth/domain/entities/user.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/data/datasources/remote_database.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/data/models/history_model.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/history.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/reward.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/repositories/steps_tracker_repositories.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/local_database.dart';

class StepsTrackerRepositoryImpl implements StepsTrackerRepository {
  final StepsRemoteDataBase remoteDataBase;
  final StepsLocalDataBase localDataBase;
  final NetworkInfo networkInfo;

  StepsTrackerRepositoryImpl(
      {required this.localDataBase,
      required this.remoteDataBase,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addUserHistory(History history) async {
    HistoryModel historyModel = HistoryModel(
        dateTime: history.dateTime, steps: history.steps, type: history.type);
    if (await networkInfo.isConnected) {
      try {
        final remoteHistory = await remoteDataBase.addUserHistory(historyModel);
        return Right(remoteHistory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getDataTracker() {
    // TODO: implement getDataTracker
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Reward>>> getRewards() {
    // TODO: implement getRewards
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<History>>> getUserHistory() async{
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataBase.getUserHistory();
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    } }

  @override
  Future<Either<Failure, Unit>> updateDataTracker(int steps) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataBase.updateDataTracker(steps);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addDataTracker(User user) {
    // TODO: implement addDataTracker
    throw UnimplementedError();
  }
}
