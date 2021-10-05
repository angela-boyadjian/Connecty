part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
}

class GetChats extends ChatListEvent {
  final List<String> chatsId;

  const GetChats(this.chatsId);

  @override
  List<Object> get props => [this.chatsId];
}

class OpenChat extends ChatListEvent {
  final String chatId;

  const OpenChat(this.chatId);

  @override
  List<Object> get props => [this.chatId];
}
