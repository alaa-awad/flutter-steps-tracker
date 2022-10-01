import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> signUp(
      {required String name});

  Future<Either<Failure, Unit>> logIn(
      {required String name});

  Future<Either<Failure, Unit>> logOut();
  Future<Either<Failure, User>> getProfile();
}
