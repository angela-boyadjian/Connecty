import 'package:connecty/ui/widgets/background.dart';
import 'package:connecty/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'widgets/general_settings.dart';
import 'widgets/informations/informations.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: tr('settings.Settings')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GeneralSettings(),
              Informations(),
            ],
          ),
        ),
      ),
    );
  }
}
