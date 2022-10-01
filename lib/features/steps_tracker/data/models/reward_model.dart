import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/reward.dart';

class RewardModel extends Reward {
  const RewardModel(
      {required super.id, required super.name, required super.healthPoints});

  factory RewardModel.fromJson(dynamic json) {
    return RewardModel(
        id: json["id"], name: json["name"], healthPoints: json["healthPoints"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "healthPoints": healthPoints,
    };
  }
}
