part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ChatStatus status;
  final List<Message> messages;

  const ChatState._({this.messages, this.status = ChatStatus.Initial});

  const ChatState.initial() : this._();

  const ChatState.empty() : this._(status: ChatStatus.Empty);

  const ChatState.loading() : this._(status: ChatStatus.Loading);

  const ChatState.success(List<Message> messages)
      : this._(messages: messages, status: ChatStatus.Success);

  const ChatState.error() : this._(status: ChatStatus.Error);

  @override
  List<Object> get props => [this.status, this.messages];
}
