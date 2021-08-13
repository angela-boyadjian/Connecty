import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(tr("settings.Notifications"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Card(
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.pause,
                  color: Colors.amber,
                ),
                title: Text(tr('settings.Pause_All')),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                title: Text(tr("settings.Likes")),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              ListTile(
                leading: Icon(
                  Icons.star,
                  color: Colors.green,
                ),
                title: Text(tr("settings.Follow")),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
              ListTile(
                leading: Icon(
                  Icons.message,
                  color: Colors.grey,
                ),
                title: Text(tr("settings.Messages")),
                trailing: Switch(value: true, onChanged: (val) {}),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
