import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/history.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/widgets/reward_page/show_dialog.dart';

import '../../../../core/functions/format_date.dart';
import '../../../../core/var.dart';
import '../../../../core/widgets/show_toast.dart';
import '../../domain/entities/reward.dart';

class RewardPage extends StatelessWidget {
  RewardPage({Key? key}) : super(key: key);

  late List<Reward> rewards;
  @override
  Widget build(BuildContext context) {
    rewards = [
      Reward(
          id: "1",
          name: getTranslated(context, "RewardPage_List_id_1_text"),
          healthPoints: 3),
      Reward(
          id: "2",
          name: getTranslated(context, "RewardPage_List_id_2_text"),
          healthPoints: 7),
      Reward(
          id: "3",
          name: getTranslated(context, "RewardPage_List_id_3_text"),
          healthPoints: 10),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "RewardPage_appBar_text")),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => rewardItem(rewards[index], context),
          separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
          itemCount: rewards.length),
    );
  }

  Widget rewardItem(Reward reward, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          height: 100,
          width: double.infinity,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward.name,
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Text(getTranslated(
                              context, "RewardPage_health_point")),
                          Text(
                            reward.healthPoints.toString(),
                            maxLines: 2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialogReward(
                          context: context,
                          title: "Health point is ${user?.healthPoint}",
                          describe: getTranslated(
                              context, "RewardPage_showDialog_title_text"),
                          function: () {
                            if (user!.healthPoint > reward.healthPoints) {
                              user!.healthPoint =
                                  user!.healthPoint - reward.healthPoints;
                              StepsTrackerCubit.get(context)
                                  .updateData(user!.stepsNumber);
                              History history = History(
                                  dateTime: formatDate(DateTime.now()),
                                  steps: 0,
                                  type:
                                      "You spend ${reward.healthPoints} health points at ${reward.name}");
                              StepsTrackerCubit.get(context)
                                  .addHistoryCubit(history);
                              showToast(
                                  state: ToastStates.success,
                                  text: getTranslated(context,
                                      "RewardPage_showDialog_success_title_text"));
                            } else {
                              showToast(
                                  state: ToastStates.error,
                                  text: getTranslated(context,
                                      "RewardPage_showDialog_error_title_text"));
                            }
                          });
                    },
                    icon: const Icon(Icons.add_circle_outline_outlined)),
              ],
            ),
          )),
    );
  }
}
