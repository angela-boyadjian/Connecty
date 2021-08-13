import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:connecty/constants/constants.dart';

part 'tab_event.dart';

class TabBloc extends Bloc<TabEvent, TabScreens> {
  TabBloc() : super(TabScreens.Home);

  @override
  Stream<TabScreens> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is TabUpdated) {
      yield event.tabScreen;
    }
  }
}
