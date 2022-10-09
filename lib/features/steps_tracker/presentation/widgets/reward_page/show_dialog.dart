
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

dynamic showDialogReward(
    {required BuildContext context,
      required String title,
      required String describe,
      required dynamic function,
      String btnOkText = 'Ok',
      String btnCancelText = 'Cancel',
    }) {
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: Theme
        .of(context)
        .scaffoldBackgroundColor,
    //dialogType: DialogType.QUESTION,
    width: 300,
    animType: AnimType.SCALE,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    title: title,
    titleTextStyle: Theme.of(context).textTheme.bodyText1,
    desc: describe,
    descTextStyle: Theme.of(context).textTheme.subtitle1,
    btnCancelOnPress: () {},
    btnOkOnPress: function,
    btnOkText: btnOkText,
    btnCancelText: btnCancelText,
  ).show();
}