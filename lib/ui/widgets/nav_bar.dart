import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:connecty/constants/constants.dart';

class NavBar extends StatelessWidget {
  final TabScreens activeTab;
  final double iconSize = 20.0;
  final GlobalKey bottomNavigationKey;
  final Color iconColor = Colors.white;
  final Function(TabScreens) onTabSelected;

  NavBar(
      {Key key,
      @required this.bottomNavigationKey,
      @required this.activeTab,
      @required this.onTabSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: bottomNavigationKey,
      index: TabScreens.values.indexOf(activeTab),
      height: 50.0,
      items: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(FontAwesomeIcons.solidAddressBook,
              size: activeTab == TabScreens.Contacts ? iconSize + 4 : iconSize,
              color: iconColor),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(FontAwesomeIcons.solidComment,
              size: activeTab == TabScreens.Home ? iconSize + 5 : iconSize,
              color: iconColor),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(FontAwesomeIcons.search,
              size: activeTab == TabScreens.Search ? iconSize + 4 : iconSize,
              color: iconColor),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(FontAwesomeIcons.userAlt,
              size: activeTab == TabScreens.Profile ? iconSize + 5 : iconSize,
              color: iconColor),
        ),
      ],
      color: Theme.of(context).primaryColor,
      buttonBackgroundColor: Colors.amber,
      backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 400),
      onTap: (index) => onTabSelected(TabScreens.values[index]),
    );
  }
}
