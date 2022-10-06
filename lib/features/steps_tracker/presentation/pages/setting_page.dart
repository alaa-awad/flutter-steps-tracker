import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/localization/get_translate.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/widgets/setting_page/theme_dialog.dart';

import '../widgets/setting_page/dialog_language.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Icon(Icons.language),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(getTranslated(context, "SettingPage_language_text")),
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
                    const Icon(Icons.language),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(getTranslated(context, "SettingPage_theme_text")),
                  ],
                ),
              ),
              onTap: () {
                showThemeDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
