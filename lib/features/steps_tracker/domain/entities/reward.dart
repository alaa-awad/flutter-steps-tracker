import 'package:equatable/equatable.dart';

class Reward extends Equatable{

  final String id;
  final String name;
  final int healthPoints;

  const Reward({required this.id,required this.name,required this.healthPoints});

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,healthPoints];


}