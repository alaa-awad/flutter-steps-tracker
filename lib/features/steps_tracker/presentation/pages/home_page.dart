import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/core/routing/navigate_to.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/history_page.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/reward_page.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/setting_page.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/walk_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/var.dart';
import '../widgets/home_page/personal_information.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  Color backgroundButtonColor = Colors.white;
  Color iconButtonColor = HexColor("#121212");
  @override
  Widget build(BuildContext context) {
    StepsTrackerCubit.get(context).getUser();
    backgroundButtonColor = theme == null || theme == "lightTheme" ?Colors.black87:Colors.white;
    iconButtonColor = theme == null || theme == "lightTheme" ?Colors.white:HexColor("#121212");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, "App_name"),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigateTo(context, const SettingPage());
          },
          icon: const Icon(Icons.settings),
        ),
      ),
      body: BlocConsumer<StepsTrackerCubit, StepsTrackerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonalInformation(),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      navigateTo(context, const WalkScreen());
                    },
                   color: backgroundButtonColor,
                    shape: const CircleBorder(),
                    child: Icon(
                      Icons.directions_walk,
                      color: iconButtonColor,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      navigateTo(context, RewardPage());
                    },
                    color: backgroundButtonColor,
                    shape: const CircleBorder(),
                    child:  Icon(
                      Icons.celebration_outlined,
                      color: iconButtonColor,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      //StepsTrackerCubit.get(context).getHistoryCubit();
                      navigateTo(context, HistoryPage());
                    },
                    color: backgroundButtonColor,
                    shape: const CircleBorder(),
                    child:  Icon(
                      Icons.date_range,
                      color: iconButtonColor,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
