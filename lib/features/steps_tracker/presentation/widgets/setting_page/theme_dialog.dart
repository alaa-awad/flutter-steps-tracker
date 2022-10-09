import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import '../../../../../core/localization/get_translate.dart';
import '../../../../../core/var.dart';
import '../../../../../core/widgets/my_divider.dart';

//Theme dialog contain and enum
enum ThemeType { light, dark }

ThemeType? themeTypeItem = ThemeType.light;

//Theme dialog
dynamic showThemeDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    dialogType: DialogType.NO_HEADER,
    width: 300,
    animType: AnimType.SCALE,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    body: const DialogContainTheme(),
  ).show();
}

class DialogContainTheme extends StatefulWidget {
  const DialogContainTheme({Key? key}) : super(key: key);

  @override
  State<DialogContainTheme> createState() => _DialogContainThemeState();
}

class _DialogContainThemeState extends State<DialogContainTheme> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(getTranslated(context, 'Setting_screen_button_theme_title'),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17)),
        const SizedBox(height: 10),
        SizedBox(
          width: 80,
          child: myDivider(),
        ),
        RadioListTile<ThemeType>(
          title: Text(
              getTranslated(context, 'Setting_screen_button_theme_lightTheme')),
          value: ThemeType.light,
          groupValue: themeTypeItem,
          onChanged: (ThemeType? value) {
            setState(() {
              themeTypeItem = value;
              theme = 'lightTheme';
            });
          },
          activeColor: Theme.of(context).iconTheme.color,
        ),
        RadioListTile<ThemeType>(
          title: Text(
              getTranslated(context, 'Setting_screen_button_theme_darkTheme')),
          value: ThemeType.dark,
          groupValue: themeTypeItem,
          onChanged: (ThemeType? value) {
            setState(() {
              themeTypeItem = value;
              theme = 'darkTheme';
            });
          },
          activeColor: Theme.of(context).iconTheme.color,
        ),
        myDivider(),
        TextButton(
          onPressed: () {
            StepsTrackerCubit.get(context).changeTheme('$theme', context);
            StepsTrackerCubit.get(context).emit(ChangeThemeState());
          },
          child: Text(
            getTranslated(context, 'Setting_screen_button_language_button'),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
