part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ChatStatus status;
  final List<Message> messagesList;

  const ChatState._({this.messagesList, this.status = ChatStatus.Initial});

  const ChatState.initial() : this._();

  const ChatState.loading() : this._(status: ChatStatus.Loading);

  const ChatState.success(List<Message> messagesList)
      : this._(messagesList: messagesList, status: ChatStatus.Success);

  const ChatState.error() : this._(status: ChatStatus.Error);

  @override
  List<Object> get props => [this.status, this.messagesList];
}
