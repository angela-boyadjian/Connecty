part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class GetMessages extends ChatEvent {
  final String id;

  const GetMessages(this.id);

  @override
  List<Object> get props => [this.id];
}

class MessageReceived extends ChatEvent {
  final Message message;

  const MessageReceived(this.message);

  @override
  List<Object> get props => [this.message];
}

class SendMessage extends ChatEvent {
  final Message message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [this.message];
}
