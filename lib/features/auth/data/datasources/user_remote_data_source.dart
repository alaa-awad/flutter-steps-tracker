import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/strings/app_string.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {

  Future<Unit> signUp({
    required String name,
  });

  Future<Unit> logOut();
}

class UserRemoteDataSourceFromFireBase implements UserRemoteDataSource {


  @override
  Future<Unit> logOut() async {
    await FirebaseAuth.instance.signOut();
    return Future.value(unit);
  }

  @override
  Future<Unit> signUp({
    required String name,
  }) async {
    await FirebaseAuth.instance.signInAnonymously().then((value) {
      UserModel user = UserModel(
        id: "${value.user?.uid}",
        name: name,
        stepsNumber: 0,
        healthPoint: 0,
      );
      AppString.userToken = "${value.user?.uid}";
      FirebaseFirestore.instance
          .collection('Users')
          .doc(value.user?.uid)
          .set(user.toJson());
    });
    return Future.value(unit);
  }
}
