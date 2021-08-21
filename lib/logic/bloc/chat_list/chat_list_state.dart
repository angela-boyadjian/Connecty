part of 'chat_list_bloc.dart';

class ChatListState extends Equatable {
  final ChatStatus status;
  final List<Chat> chats;

  const ChatListState._({this.chats, this.status = ChatStatus.Initial});

  const ChatListState.initial() : this._();

  const ChatListState.loading() : this._(status: ChatStatus.Loading);

  const ChatListState.success(List<chat> chats)
      : this._(chats: chats, status: ChatStatus.Success);

  const ChatListState.error() : this._(status: ChatStatus.Error);

  @override
  List<Object> get props => [this.status, this.chats];
}
