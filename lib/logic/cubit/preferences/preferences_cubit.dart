import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:connecty/constants/constants.dart';

part 'preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  SharedPreferences _prefs;
  bool _theme;
  bool _tutorial;

  PreferencesCubit() : super(PreferencesInitial()) {
    _loadPrefs();
  }

  bool get theme => _theme;
  bool get tutorial => _tutorial;

  Future<void> _loadPrefs() async {
    emit(PreferencesLoading());
    _prefs = await SharedPreferences.getInstance();
    emit(PreferencesLoaded());
  }

  void loadTheme() {
    final bool theme = _prefs.getBool(themePref) ?? true;
    _theme = theme;
    emit(PreferencesTheme(theme));
  }

  void setTheme(bool newTheme) {
    _prefs.setBool(themePref, newTheme);
    _theme = newTheme;
    emit(PreferencesTheme(newTheme));
  }

  void loadTutorial() {
    final bool tutorial = _prefs.getBool(tutorialPref) ?? true;
    _tutorial = tutorial;
    emit(PreferencesTutorial(tutorial));
  }

  void setTutorial(bool newTutorial) {
    _prefs.setBool(tutorialPref, newTutorial);
    _tutorial = newTutorial;
    emit(PreferencesTutorial(newTutorial));
  }
}
