import 'package:connecty/ui/widgets/background.dart';
import 'package:connecty/ui/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'panels.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final List<PanelData> items = [
    const PanelData('settings.Privacy.1.title', 'settings.Privacy.1.content'),
    const PanelData('settings.Privacy.2.title', 'settings.Privacy.2.content'),
    const PanelData('settings.Privacy.3.title', 'settings.Privacy.3.content'),
    const PanelData('settings.Privacy.4.title', 'settings.Privacy.4.content'),
    const PanelData('settings.Privacy.5.title', 'settings.Privacy.5.content'),
    const PanelData('settings.Privacy.6.title', 'settings.Privacy.6.content'),
    const PanelData('settings.Privacy.7.title', 'settings.Privacy.7.content'),
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: 'settings.Privacy.title'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tr('settings.Privacy.intro'),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Panels(numberOfPanels: 7, items: items),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
