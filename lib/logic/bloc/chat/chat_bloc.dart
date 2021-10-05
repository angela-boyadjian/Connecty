import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data/data_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:connecty/constants/constants.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String _chatId;
  final DataRepository _dataRepository;
  StreamSubscription<List<Message>> _chatSubscription;

  ChatBloc({
    @required DataRepository dataRepository,
    @required String chatId,
  })  : _dataRepository = dataRepository,
        _chatId = chatId,
        super(const ChatState.initial()) {
    _chatSubscription = _dataRepository.messages(_chatId).listen((messages) {
      add(MessageReceived(messages));
    });
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    yield ChatState.loading();
    if (event is SendMessage) {
      yield* _mapSendToState(event.message);
    } else if (event is MessageReceived) {
      yield ChatState.updated(event.message);
    }
  }

  Stream<ChatState> _mapSendToState(Message message) async* {
    try {
      await _dataRepository.sendMessage(message, _chatId);
      yield ChatState.messageSent();
    } on Exception {
      yield ChatState.error();
    }
  }

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    return super.close();
  }
}
