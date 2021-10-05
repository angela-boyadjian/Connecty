import 'package:data/models/chat.dart';
import 'package:data/models/message.dart';

class SendMessageFailure implements Exception {}
class ReadMessageFailure implements Exception {}
class GetChatsFailure implements Exception {}
class GetMessagesFailure implements Exception {}

abstract class AProvider {
  /// Sends [Message] to user.
  /// Throws a [SendMessageFailure] if an exception occurs.
  Future<void> sendMessage(Message message, String chatId);

  /// Updates chat collection for unread.
  /// Throws a [ReadMessageFailure] if an exception occurs.
  Future<Chat> readMessage(String chatId);

  /// Fetch [List<Chat>] to user.
  /// Throws a [GetChatsFailure] if an exception occurs.
  Future<List<Chat>> getChats(List<String> chatsId);

  /// Listens for changes and returns a [List<Message>] to user.
  /// Throws a [GetMessages>Failure] if an exception occurs.
  Stream<List<Message>> messages(String chatId);
}
