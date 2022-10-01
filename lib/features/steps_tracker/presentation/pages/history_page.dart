import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';

import '../../../../core/var.dart';
import '../../domain/entities/history.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
  StepsTrackerCubit.get(context).getHistoryCubit();
    return BlocConsumer<StepsTrackerCubit,StepsTrackerState>
      (builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, "HistoryPage_appBar_text")),
            centerTitle: true,
          ),
          body: ListView.separated(
              itemBuilder: (context, index) => rewardItem(histories[index], context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: histories.length),
        );
    }, listener: (context,state){});
  }

  Widget rewardItem(History history, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          height:90,
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    history.dateTime,
                    maxLines: 2,
                  ),
                  Text(
                    history.type,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
