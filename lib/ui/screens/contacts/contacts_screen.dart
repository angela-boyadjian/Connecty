import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:connecty/constants/constants.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  Widget _buildAppBar(textTheme) => AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    leading: Container(),
    centerTitle: true,
    title: Text('Contacts',
        style: textTheme.headline5.copyWith(color: Colors.white)),
    actions: [
      IconButton(
          icon: Icon(FontAwesomeIcons.plus, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, settingsRoute)),
    ],
  );
      
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(textTheme),
      body: Center(
        child: Text(
          'CONTACTS SCREEN',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
