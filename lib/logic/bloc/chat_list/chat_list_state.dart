part of 'chat_list_bloc.dart';

class ChatListState extends Equatable {
  final ChatStatus status;
  final List<Chat> chats;
  final Chat chat;

  const ChatListState._({this.chat, this.chats, this.status = ChatStatus.Initial});

  const ChatListState.initial() : this._();

  const ChatListState.loading() : this._(status: ChatStatus.Loading);

  const ChatListState.empty() : this._(status: ChatStatus.Empty);

  const ChatListState.openChat(List<Chat> chats, Chat chat)
      : this._(chats: chats, chat: chat, status: ChatStatus.Success);

  const ChatListState.success(List<Chat> chats)
      : this._(chats: chats, status: ChatStatus.Success);

  const ChatListState.error() : this._(status: ChatStatus.Error);

  @override
  List<Object> get props => [this.status, this.chats];
}
