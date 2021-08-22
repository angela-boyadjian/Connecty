import 'package:data/models/chat.dart';
import 'package:data/models/message.dart';

class SendMessageFailure implements Exception {}

class GetChatsFailure implements Exception {}

class GetMessagesFailure implements Exception {}

abstract class AProvider {
  /// Sends [Message] to user.
  /// Throws a [SendMessageFailure] if an exception occurs.
  Future<void> sendMessage(Message message);

  /// Fetch [List<Chat>] to user.
  /// Throws a [GetChatsFailure] if an exception occurs.
  Future<List<Chat>> getChats(List<String> chatsId);

  /// Fetch [List<Message>] to user.
  /// Throws a [GetMessages>Failure] if an exception occurs.
  Future<List<Message>> getMessages(String id);
}
