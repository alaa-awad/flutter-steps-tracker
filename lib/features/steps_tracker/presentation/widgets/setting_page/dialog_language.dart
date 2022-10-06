import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/localization/get_translate.dart';
import '../../../../../core/var.dart';
import '../../../../../core/widgets/my_divider.dart';
import '../../cubit/steps_tracker_cubit.dart';

LanguageType? languageTypeItem = LanguageType.defaults;

dynamic showLanguageDialog(BuildContext context) {
  return AwesomeDialog(
    context: context,
    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
    dialogType: DialogType.NO_HEADER,
    width: 300,
    animType: AnimType.SCALE,
    buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
    body: const DialogContainLanguage(),
  ).show();
}

//Language dialog contain and enum
enum LanguageType { defaults, ar, en }

class DialogContainLanguage extends StatefulWidget {
  const DialogContainLanguage({Key? key}) : super(key: key);

  @override
  State<DialogContainLanguage> createState() => _DialogContainLanguageState();
}

class _DialogContainLanguageState extends State<DialogContainLanguage> {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          Text(
            getTranslated(context, 'Setting_screen_button_language_title'),
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 80,
            child: myDivider(),
          ),
          RadioListTile<LanguageType>(
            title: Text(
              getTranslated(
                  context, 'Setting_screen_button_language_default'),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            value: LanguageType.defaults,
            groupValue: languageTypeItem,
            onChanged: (LanguageType? value) {
             setState(() {
               languageTypeItem = value;
               language = 'Default';

             });
            },
            activeColor: Theme.of(context).iconTheme.color,
          ),
          RadioListTile<LanguageType>(
            title: Text(
              'العربية',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            value: LanguageType.ar,
            groupValue: languageTypeItem,
            onChanged: (LanguageType? value) {
              setState(() {
                languageTypeItem = value;
                language = 'ar';

              });
            },
            activeColor: Theme.of(context).iconTheme.color,
          ),
          RadioListTile<LanguageType>(
            title: Text(
              'English',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            value: LanguageType.en,
            groupValue: languageTypeItem,
            onChanged: (LanguageType? value) {
           setState(() {
             languageTypeItem = value;
             language = 'en';
           });

            },
            activeColor: Theme.of(context).iconTheme.color,
          ),
          myDivider(),
          TextButton(
            onPressed: () {
              StepsTrackerCubit.get(context)
                  .changeLanguage(language!, context);
              StepsTrackerCubit.get(context).emit(ChangeLanguageState());
            },
            child: Text(
              getTranslated(
                  context, 'Setting_screen_button_language_button'),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
