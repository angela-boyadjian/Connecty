part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();
}

class GetChats extends ChatListEvent {
  final List<Chat> chats;

  const GetChats(this.chats);

  @override
  List<Object> get props => [this.chats];
}
