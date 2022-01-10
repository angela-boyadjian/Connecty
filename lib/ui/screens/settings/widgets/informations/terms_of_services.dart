import 'package:connecty/ui/widgets/background.dart';
import 'package:connecty/ui/widgets/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'panels.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({Key key}) : super(key: key);

  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  final List<PanelData> items = [
    const PanelData('settings.Tos.1.title', 'settings.Tos.1.content'),
    const PanelData('settings.Tos.2.title', 'settings.Tos.2.content'),
    const PanelData('settings.Tos.3.title', 'settings.Tos.3.content'),
    const PanelData('settings.Tos.4.title', 'settings.Tos.4.content'),
    const PanelData('settings.Tos.5.title', 'settings.Tos.5.content'),
    const PanelData('settings.Tos.6.title', 'settings.Tos.6.content'),
    const PanelData('settings.Tos.7.title', 'settings.Tos.7.content'),
    const PanelData('settings.Tos.8.title', 'settings.Tos.8.content'),
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: 'settings.Tos.title'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tr('settings.Tos.intro'),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Panels(numberOfPanels: 8, items: items),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
