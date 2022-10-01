import '../../domain/entities/history.dart';

class HistoryModel extends History {
  const HistoryModel(
      {required super.dateTime, required super.steps, required super.type});

  factory HistoryModel.fromJson(dynamic json) {
    return HistoryModel(
        dateTime: json["dateTime"], steps: json["steps"], type: json["type"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "dateTime": dateTime,
      "steps": steps,
      "type": type,
    };
  }
}
