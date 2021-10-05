import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:data/data_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:connecty/constants/constants.dart';
import 'package:flutter/material.dart';

part 'chat_list_state.dart';
part 'chat_list_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final DataRepository _dataRepository;
  List<Chat> _chats = [];

  ChatListBloc({
    @required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const ChatListState.initial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    yield ChatListState.loading();
    if (event is GetChats) {
      yield* _mapGetToState(event.chatsId);
    } else if (event is OpenChat) {
      yield* _mapOpenToState(event.chatId);
    }
  }

  Stream<ChatListState> _mapOpenToState(String chatId) async* {
    try {
      Chat chat = await _dataRepository.readMessage(chatId);
      for (int i = 0; i < _chats.length; ++i) {
        if (_chats[i].id == chat.id) {
          _chats[i] = chat;
          break;
        }
      }
      yield ChatListState.success(_chats);
    } on Exception {
      yield ChatListState.error();
    }
  }

  Stream<ChatListState> _mapGetToState(List<String> chatsId) async* {
    try {
      if (chatsId == null) {
        yield ChatListState.empty();
      } else {
        _chats = await _dataRepository.getChats(chatsId);
        yield ChatListState.success(_chats);
      }
    } on Exception {
      yield ChatListState.error();
    }
  }
}
