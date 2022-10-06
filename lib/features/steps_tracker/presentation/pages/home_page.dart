import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/core/routing/navigate_to.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/history_page.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/reward_page.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/setting_page.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/walk_screen.dart';
import '../widgets/home_page/personal_information.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StepsTrackerCubit.get(context).getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "App_name")),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          navigateTo(context, SettingPage());
        },icon: const Icon(Icons.settings),),
      ),
      body: BlocConsumer<StepsTrackerCubit,StepsTrackerState>(
        listener: (context,state){},
        builder: (context,state){
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
                    color: Colors.black87,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.directions_walk,
                      color: Colors.white,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      navigateTo(context, RewardPage());
                    },
                    color: Colors.black87,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.celebration_outlined,
                      color: Colors.white,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      //StepsTrackerCubit.get(context).getHistoryCubit();
                      navigateTo(context, HistoryPage());
                    },
                    color: Colors.black87,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.date_range,
                      color: Colors.white,
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
