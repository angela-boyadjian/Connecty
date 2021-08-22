import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data/data_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:connecty/constants/constants.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final DataRepository _dataRepository;

  ChatBloc({
    @required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const ChatState.initial());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    yield ChatState.loading();
    if (event is GetMessages) {
      print('EVENT IS CALLED');
      yield* _mapGetToState(event.id);
    } else if (event is SendMessage) {
      yield* _mapSendToState(event.message);
    }
  }

  Stream<ChatState> _mapGetToState(String id) async* {
    try {
      if (id == null) {
        yield ChatState.empty();
      } else {
        List<Message> messages = await _dataRepository.getMessages(id);
        print(messages[0].content);
        yield ChatState.success(messages);
      }
    } on Exception {
      yield ChatState.error();
    }
  }

  Stream<ChatState> _mapSendToState(Message message) async* {
    try {
      // SendMessage via repository'
      // yield ChatState.success();
    } on Exception {
      yield ChatState.error();
    }
  }
}
