import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/logic/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    yield ChatState.loading();
  }
}
