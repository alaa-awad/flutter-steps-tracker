import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/core/routing/navigate_and_finish.dart';
import 'package:flutter_steps_tracker/features/auth/presentation/cubit/user_cubit.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/widgets/setting_page/theme_dialog.dart';
import '../../../../core/localization/get_os.dart';
import '../../../../core/widgets/adaptive/adaptive_button.dart';
import '../../../auth/presentation/pages/register_screen.dart';
import '../widgets/setting_page/dialog_language.dart';
import '../../../../core/injection_container.dart' as di;

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserState>(
      listener: (context,state){
        if(state is LogOutSuccessState){
          navigateAndFinish(context, RegisterScreen());
        }
      },
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, "SettingPage_appBar_text")),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InkWell(
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Icon(Icons.language,
                            color: Theme.of(context).iconTheme.color),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          getTranslated(context, "SettingPage_language_text"),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showLanguageDialog(context);
                  },
                ),
                const SizedBox(),
                InkWell(
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        Icon(
                          Icons.format_paint,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          getTranslated(context, "SettingPage_theme_text"),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showThemeDialog(context);
                  },
                ),
                const Spacer(),
                AdaptiveButton(
                  radius: 20,
                  function: () {
                    UserCubit.get(context).logOutCubit();
                    //   navigateAndFinish(context, RegisterScreen());
                  },
                  text: getTranslated(context, 'SettingPage_button_logOut'),
                  isUpperCase: true,
                  background: Theme.of(context).buttonColor,
                  os: getOs(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
