import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final int stepsNumber;
   int healthPoint;

   User({
    required this.stepsNumber,
    required this.healthPoint,
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name, stepsNumber,healthPoint];
}
