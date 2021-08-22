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
    }
  }

  Stream<ChatListState> _mapGetToState(List<String> chatsId) async* {
    try {
      if (chatsId == null) {
        yield ChatListState.empty();
      } else {
        List<Chat> chats = await _dataRepository.getChats(chatsId);
        yield ChatListState.success(chats);
      }
    } on Exception {
      yield ChatListState.error();
    }
  }
}
