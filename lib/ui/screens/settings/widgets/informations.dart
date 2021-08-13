import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Informations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  title: Text(tr("Security")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.ad,
                    color: Colors.orange,
                  ),
                  title: Text(tr("settings.Ads")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Colors.green,
                  ),
                  title: Text(tr("settings.community.Community_Guidelines")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.gavel,
                    color: Colors.lightGreen,
                  ),
                  title: Text(tr("settings.tos.Terms_of_Services")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
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
              GestureDetector(
                child: ListTile(
                  leading: Icon(
                    Icons.help,
                    color: Colors.pink,
                  ),
                  title: Text(tr("settings.Help")),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
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
