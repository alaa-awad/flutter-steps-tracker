import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_steps_tracker/core/var.dart';
import 'package:flutter_steps_tracker/features/auth/domain/entities/user.dart';
import '../../../../core/strings/app_string.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Unit> logIn({
    required String name,
  });
  Future<Unit> signUp({
    required String name,
  });

  Future<Unit> logOut();
  Future<UserModel> getProfile();
}

class UserRemoteDataSourceFromFireBase implements UserRemoteDataSource {



  @override
  Future<Unit> logIn({
    required String name,
  }) async {
    await FirebaseAuth.instance.signInAnonymously().then((value) {
      // UserModel user = UserModel(id: "${value.user?.uid}", name: name, stepsNumber: "0", healthPoint: '0',);
      AppString.userToken = "${value.user?.uid}";
      print("User token is ${value.user?.uid}");
    });
    return Future.value(unit);
  }

  @override
  Future<Unit> logOut() async {
    ///ToDo:complete the code
    await FirebaseAuth.instance.signOut();
    return Future.value(unit);
  }

  @override
  Future<Unit> signUp({
    required String name,
  }) async {
    await FirebaseAuth.instance.signInAnonymously().then((value) {
      UserModel user = UserModel(
          id: "${value.user?.uid}", name: name, stepsNumber: 0, healthPoint: 0,);
      AppString.userToken = "${value.user?.uid}";
        FirebaseFirestore.instance
          .collection('Users')
          .doc(value.user?.uid)
          .set(user.toJson());
    });
    return Future.value(unit);
  }

  @override
  Future<UserModel> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
}
