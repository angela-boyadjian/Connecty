import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connecty/ui/screens/chat/mock.dart';
import 'package:equatable/equatable.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/constants/constants.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> _messagesList = [];

  ChatBloc() : super(ChatState.initial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    yield ChatState.loading();
    if (event is MessageReceived) {
      yield ChatState.success(_messagesList);
    } else if (event is SendMessage) {
      yield* _mapSendToState(event.message);
    }
  }

  Stream<ChatState> _mapSendToState(Message message) async* {
    try {
      // SendMessage via repository'
      _messagesList.add(message);
      yield ChatState.success(_messagesList);
    } on Exception {
      yield ChatState.error();
    }
  }
}
