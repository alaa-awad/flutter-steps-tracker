import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {

//  List<History> histories;
   UserModel({
    required super.id,
    required super.name,
    required super.stepsNumber,
    required super.healthPoint,
    // required this.histories
  });


  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      stepsNumber: json["stepsNumber"],
      healthPoint: json["healthPoints"],
     // histories: json["History"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "stepsNumber": stepsNumber,
      "healthPoints": healthPoint,
    //  "History": histories,
    };
  }
}

/*
class History extends Equatable{

final String dateTime;
final String stepsNumber;

  const History({required this.dateTime,required this.stepsNumber});

  @override
  List<Object?> get props => [dateTime,stepsNumber];
}*/
