import 'package:connecty/ui/widgets/background.dart';
import 'package:connecty/ui/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'panels.dart';

class CommunityGuidelines extends StatefulWidget {
  const CommunityGuidelines({Key key}) : super(key: key);

  @override
  _CommunityGuidelinesState createState() => _CommunityGuidelinesState();
}

class _CommunityGuidelinesState extends State<CommunityGuidelines> {
  final List<PanelData> items = [
    const PanelData(
        'settings.Community.1.title', 'settings.Community.1.content'),
    const PanelData(
        'settings.Community.2.title', 'settings.Community.2.content'),
    const PanelData(
        'settings.Community.3.title', 'settings.Community.3.content'),
    const PanelData(
        'settings.Community.4.title', 'settings.Community.4.content'),
    const PanelData(
        'settings.Community.5.title', 'settings.Community.5.content'),
    const PanelData(
        'settings.Community.6.title', 'settings.Community.6.content'),
    const PanelData(
        'settings.Community.7.title', 'settings.Community.7.content'),
    const PanelData(
        'settings.Community.8.title', 'settings.Community.8.content'),
    const PanelData(
        'settings.Community.9.title', 'settings.Community.9.content'),
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: 'settings.Community.title'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tr('settings.Community.intro'),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Panels(numberOfPanels: 9, items: items),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
