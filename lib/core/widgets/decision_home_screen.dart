import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/home_page.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../cache_helper/cache_helper.dart';
import '../strings/app_string.dart';

late Widget home;

void decisionHomeScreen() {
  AppString.userToken = CacheHelper.getData(key: 'uId');
  if (AppString.userToken != null) {
    home = const HomePage();
  } else {
    home = RegisterScreen();
  }
}
