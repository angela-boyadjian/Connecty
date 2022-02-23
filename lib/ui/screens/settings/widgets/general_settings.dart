import 'package:connecty/ui/widgets/custom_divider.dart';
import 'package:connecty/ui/widgets/glassmorphism.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/logic/cubit/preferences/preferences_cubit.dart';

class GeneralSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(tr("settings.General_Settings"),
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        GlassMorphism(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  var data = EasyLocalization.of(context);
                  Localizations.localeOf(context).languageCode == "en"
                      ? data.setLocale(Locale("fr", "FR"))
                      : data.setLocale(Locale("en", "US"));
                },
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.language,
                    color: Colors.lightGreen,
                  ),
                  title: Text(tr("Language")),
                  trailing: Localizations.localeOf(context).languageCode == "en"
                      ? Image.asset('icons/flags/png/gb.png',
                          package: 'country_icons', height: 40, width: 40)
                      : Image.asset('icons/flags/png/fr.png',
                          package: 'country_icons', height: 40, width: 40),
                ),
              ),
              CustomDivider(width: width),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.solidSun,
                  color: Colors.amber[800],
                ),
                title: Text(tr('settings.Light_Theme')),
                trailing: BlocBuilder<PreferencesCubit, PreferencesState>(
                  builder: (context, state) {
                    return Switch(
                      value: context.watch<PreferencesCubit>().theme,
                      onChanged: (val) =>
                          context.read<PreferencesCubit>().setTheme(val),
                    );
                  },
                ),
              ),
              CustomDivider(width: width),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.graduationCap,
                  color: Colors.white,
                ),
                title: Text(tr('settings.Tutorial')),
                trailing: BlocBuilder<PreferencesCubit, PreferencesState>(
                  builder: (context, state) {
                    return Switch(
                      value: context.watch<PreferencesCubit>().tutorial,
                      onChanged: (val) =>
                          context.read<PreferencesCubit>().setTutorial(val),
                    );
                  },
                ),
              ),
              GestureDetector(
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false,
                        arguments: false);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    title: Text(tr("Logout")),
                    trailing: Icon(Icons.arrow_right),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
