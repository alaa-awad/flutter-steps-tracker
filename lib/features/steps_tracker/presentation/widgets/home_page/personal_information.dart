import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/core/var.dart';

class PersonalInformation extends StatelessWidget {
   PersonalInformation({Key? key}) : super(key: key);

  TextStyle textStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold

  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(user?.name??"",style: textStyle.copyWith(fontSize: 24,),),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(getTranslated(context, "PersonalInformation_text_steps_number"),style: textStyle,),
          const SizedBox(width: 20,),
          Text(user?.stepsNumber.toString()??"",style: textStyle,)
        ],),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(getTranslated(context, "PersonalInformation_text_health_point"),style: textStyle,),
          const SizedBox(width: 20,),
          Text(user?.healthPoint.toString()??"",style: textStyle,)
        ],),
      ],
    );
    
  }
}
