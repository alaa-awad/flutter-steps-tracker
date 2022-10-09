import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_steps_tracker/features/auth/presentation/cubit/user_cubit.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import 'core/bloc_observer.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/localization/app_local.dart';
import 'core/injection_container.dart' as di;
import 'core/themes/app_theme.dart';
import 'core/var.dart';
import 'core/widgets/decision_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  decisionHomeScreen();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => di.sl<StepsTrackerCubit>(),
        ),
        BlocProvider(
          create: (BuildContext context) => di.sl<UserCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,

          ///ToDo: solve problem add language
          AppLocale.delegate,
        ],
        localeResolutionCallback: (currentLocale, supportedLocale) {
          if (currentLocale != null) {
            for (Locale locale in supportedLocale) {
              if (currentLocale.languageCode == locale.languageCode) {
                return currentLocale;
              }
            }
          }
          return supportedLocale.first;
        },
        locale:
            language != null ? Locale("$language", '') : const Locale("en", ""),
        debugShowCheckedModeBanner: false,
        theme: theme == null || theme == "lightTheme" ? lightTheme : darkTheme,
        home: home,
      ),
    );
  }
}
