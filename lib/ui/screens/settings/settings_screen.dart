import 'package:connecty/ui/widgets/background.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'widgets/general_settings.dart';
import 'widgets/informations.dart';
import 'widgets/notifications_settings.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _buildAppBar() => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text(tr('settings.Settings'),
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white)),
      );

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GeneralSettings(),
                NotificationSettings(),
                Informations(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
