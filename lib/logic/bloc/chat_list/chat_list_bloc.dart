import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:data/data_repository.dart';
import 'package:connecty/constants/constants.dart';

part 'chat_list_state.dart';
part 'chat_list_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final DataRepository _dataRepository;
  List<Chat> _chats = [];
  StreamSubscription<List<Chat>> _chatSubscription;

  ChatListBloc({
    @required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const ChatListState.initial()) {
    _chatSubscription = _dataRepository.chats().listen((chats) {
      add(ChatsUpdated(chats));
    });
  }

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    yield ChatListState.loading();
    if (event is GetChats) {
      yield* _mapGetToState(event.chatsId);
    } else if (event is OpenChat) {
      yield* _mapOpenToState(event.chatId);
    } else if (event is ChatsUpdated) {
      yield* _mapUpdatedToState(event.chats);
    } else if (event is CreateChat) {
      yield* _mapCreateToState(event.chat, event.userChats, event.contactChats);
    }
  }

  Chat getChat(String chatId) {
    return _chats.where((chat) => chat.id == chatId).first;
  }

  Stream<ChatListState> _mapCreateToState(
      Chat chat, List<String> userChats, List<String> contactChats) async* {
    try {
      await _dataRepository.createChat(chat, userChats, contactChats);
      _chats.add(chat);
      yield ChatListState.success(_chats);
    } on Exception {
      yield ChatListState.error();
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

  Stream<ChatListState> _mapUpdatedToState(List<Chat> chats) async* {
    try {
      if (chats.isEmpty) {
        yield ChatListState.empty();
      } else {
        yield ChatListState.success(chats);
      }
    } on Exception {
      yield ChatListState.error();
    }
  }

  Stream<ChatListState> _mapGetToState(List<String> chatsId) async* {
    try {
      if (chatsId == null || chatsId.length == 0) {
        yield ChatListState.empty();
      } else {
        _chats = await _dataRepository.getChats(chatsId);
        yield ChatListState.success(_chats);
      }
    } on Exception {
      yield ChatListState.error();
    }
  }

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    return super.close();
  }
}
