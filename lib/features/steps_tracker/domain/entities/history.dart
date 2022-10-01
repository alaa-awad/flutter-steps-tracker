import 'package:equatable/equatable.dart';

class History extends Equatable {
  final String dateTime;
  final int steps;
  final String type;

  const History(
      {required this.dateTime, required this.steps, required this.type});

  @override
  List<Object?> get props => [dateTime,steps,type];
}
