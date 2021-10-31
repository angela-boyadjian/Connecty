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

class ChatsUpdated extends ChatListEvent {
  final List<Chat> chats;

  const ChatsUpdated(this.chats);

  @override
  List<Object> get props => [this.chats];
}

class CreateChat extends ChatListEvent {
  final Chat chat;
  final List<String> userChats;
  final List<String> contactChats;

  const CreateChat(this.chat, this.userChats, this.contactChats);

  @override
  List<Object> get props => [this.chat];
}

class OpenChat extends ChatListEvent {
  final String chatId;

  const OpenChat(this.chatId);

  @override
  List<Object> get props => [this.chatId];
}
