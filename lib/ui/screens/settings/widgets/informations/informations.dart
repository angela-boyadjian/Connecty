import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/widgets/custom_divider.dart';
import 'package:connecty/ui/widgets/glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Informations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(tr("Informations"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        GlassMorphism(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(communityRoute),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.orange,
                  ),
                  title: Text(tr("settings.Community.title")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              CustomDivider(width: width),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(tosRoute),
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.gavel,
                    color: Colors.lightGreen,
                  ),
                  title: Text(tr("settings.Tos.title")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              CustomDivider(width: width),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.visibility,
                    color: Colors.lime,
                  ),
                  title: Text(tr("settings.privacy.Privacy_Policy")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              CustomDivider(width: width),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
                title: Text(tr("settings.About")),
                trailing: Text("Version 1.0"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
