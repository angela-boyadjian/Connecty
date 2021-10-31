import 'package:data/models/chat.dart';
import 'package:data/models/message.dart';

class SendMessageFailure implements Exception {}

class ReadMessageFailure implements Exception {}

class GetChatsFailure implements Exception {}

class GetMessagesFailure implements Exception {}

class CreateChatFailure implements Exception {}

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

  /// Creates new [Chat].
  /// Throws a [CreateChatFailure] if an exception occurs.
  Future<void> createChat(
      Chat chat, List<String> userChats, List<String> contactChats);

  /// Listens for changes and returns a [List<Message>] to user.
  Stream<List<Chat>> chats();

  /// Listens for changes and returns a [List<Message>] to user.
  Stream<List<Message>> messages(String chatId);
}
