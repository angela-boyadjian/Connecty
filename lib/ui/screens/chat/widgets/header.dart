import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:connecty/ui/widgets/avatar.dart';

class Header extends StatelessWidget {
  final String name;
  final String url;

  Header(this.name, this.url);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.0,
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  tr("Online"),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white60),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Avatar(url: url),
            ),
          ],
        ),
      ),
    );
  }
}
