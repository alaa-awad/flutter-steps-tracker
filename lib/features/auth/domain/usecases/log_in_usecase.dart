import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class LogInUseCase {
  final UserRepository repository;

  LogInUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
      {required String name,}) async {
    return await repository.logIn(name:name);
  }
}
