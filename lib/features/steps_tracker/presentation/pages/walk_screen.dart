import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/routing/navigate_and_finish.dart';
import 'package:flutter_steps_tracker/core/routing/navigate_to.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/entities/history.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/pages/home_page.dart';
import 'package:pedometer/pedometer.dart';
import '../../../../core/functions/format_date.dart';
import '../../../../core/localization/get_translate.dart';
import '../../../../core/var.dart';
import '../../../../core/widgets/show_toast.dart';

class WalkScreen extends StatefulWidget {
  const WalkScreen({Key? key}) : super(key: key);

  @override
  State<WalkScreen> createState() => _WalkScreenState();
}

class _WalkScreenState extends State<WalkScreen> {
  late Stream<StepCount> _stepCountStream;

  late Stream<PedestrianStatus> _pedestrianStatusStream;

  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _steps = user?.stepsNumber.toString() ?? "?";
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
      if (_status == "stopped") {
        user?.healthPoint = int.parse(_steps) ~/ 100;
        StepsTrackerCubit.get(context).updateData(int.parse(_steps));
        History history = History(
            dateTime: formatDate(event.timeStamp),
            steps: int.parse(_steps),
            type: "increase step by ${int.parse(_steps) - user!.stepsNumber} ");
        StepsTrackerCubit.get(context).addHistoryCubit(history);
      }
      if (int.parse(_steps) - user!.stepsNumber > 100) {
        user!.healthPoint = user!.healthPoint + 1;
        showToast(
            text: 'You have reward extra health point',
            state: ToastStates.success);
      }
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    //  StepsTrackerCubit.get(context).updateData(int.parse(_steps));
    // StepsTrackerCubit.get(context).setData();
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "WalkPage_appBar_text")),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios),onPressed: (){
          navigateAndFinish(context, const HomePage());
        },),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Steps taken:',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _steps,
              style: const TextStyle(fontSize: 60),
            ),
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            const Text(
              'Pedestrian status:',
              style: TextStyle(fontSize: 30),
            ),
            Icon(
              _status == 'walking'
                  ? Icons.directions_walk
                  : _status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 100,
            ),
            Center(
              child: Text(
                _status,
                style: _status == 'walking' || _status == 'stopped'
                    ? const TextStyle(fontSize: 30)
                    : const TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
