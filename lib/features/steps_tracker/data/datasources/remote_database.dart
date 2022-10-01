import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/strings/app_string.dart';
import '../../../../core/var.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/history_model.dart';
import '../models/reward_model.dart';

abstract class StepsRemoteDataBase {
  Future<UserModel> getDataTracker();
  Future<Unit> addDataTracker(UserModel user);
  Future<Unit> updateDataTracker(int steps);
  Future<List<RewardModel>> getRewards();
  Future<List<HistoryModel>> getUserHistory();
  Future<Unit> addUserHistory(HistoryModel history);
}

class StepsRemoteDataBaseFromFirebase implements StepsRemoteDataBase {
  @override
  Future<Unit> addUserHistory(HistoryModel history) async {
    int newSteps = history.steps - (user?.stepsNumber)!.toInt();
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(AppString.userToken)
        .collection("History")
        .doc(history.dateTime)
        .set(history.toJson())
        .then((value) {
      print("done");
    });
    return Future.value(unit);
  }

  @override
  Future<UserModel> getDataTracker() async {
    late UserModel userModel;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(AppString.userToken)
        .get()
        .then((value) {
      print(value.data());
      user = UserModel.fromJson(value.data());
      userModel = UserModel.fromJson(value.data());
      print(user);
    });

    return userModel;
  }

  @override
  Future<List<RewardModel>> getRewards() async {
    List<RewardModel> rewards = [];
    await FirebaseFirestore.instance.collection("rewards").get().then((value) {
      for (var element in value.docs) {
        rewards.add(RewardModel.fromJson(element.data()));
      }
    });
    return rewards;
  }

  @override
  Future<Unit> updateDataTracker(int steps) async {
    UserModel userModel = UserModel(
        stepsNumber: steps,
        healthPoint: user!.healthPoint,
        id: "${AppString.userToken}",
        name: user!.name);
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(AppString.userToken)
        .set(userModel.toJson())
        .then((value) {
      print("done");
    });
    return Future.value(unit);
  }

  @override
  Future<Unit> addDataTracker(UserModel user) {
    // TODO: implement addDataTracker
    throw UnimplementedError();
  }

  @override
  Future<List<HistoryModel>> getUserHistory() async {
    List<HistoryModel> historiess = [];
    histories = [];
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(AppString.userToken)
        .collection("History")
        .get()
        .then((value) {

      for (var element in value.docs) {
        histories.add(HistoryModel.fromJson(element.data()));
      }
    });
    return historiess;
  }
}
