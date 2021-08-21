import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:connecty/constants/constants.dart';

part 'chat_list_state.dart';
part 'chat_list_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListState.initial());

  @override
  Stream<ChatListState> mapEventToState(
    ChatListEvent event,
  ) async* {
    yield ChatListState.loading();
    if (event is GetChats) {
      yield* _mapGetToState(event.chats);
    }
  }

  Stream<ChatListState> _mapGetToState(List<Chat> chats) async* {
    try {
      // fetch chats
      yield ChatListState.success(chats);
    } on Exception {
      yield ChatListState.error();
    }
  }
}
