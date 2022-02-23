import 'package:connecty/ui/widgets/background.dart';
import 'package:connecty/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/ui/widgets/avatar.dart';
import 'package:connecty/constants/constants.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _buildAppBar(textTheme) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Container(),
        centerTitle: true,
        title: Text(tr('Profile'),
            style: textTheme.headline5.copyWith(color: Colors.white)),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.cog, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, settingsRoute)),
        ],
      );
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((UserBloc bloc) => bloc.state.user);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: _buildAppBar(textTheme),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Avatar(url: user?.photo, size: 70.0),
              ),
              SizedBox(height: 20.0),
              Text(user?.name ?? '',
                  style: textTheme.headline5
                      .copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Text(user?.email ?? '', style: textTheme.headline6),
              SizedBox(height: 20.0),
              Text(user?.bio ?? '', style: textTheme.headline6),
              SizedBox(height: 20.0),
              Button(
                text: tr('Edit'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(profileEditRoute),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
