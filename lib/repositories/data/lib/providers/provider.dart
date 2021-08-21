import 'package:data/models/message.dart';
import 'package:data/models/chat.dart';

class SendMessageFailure implements Exception {}
class GetChatsFailure implements Exception {}

abstract class AProvider {
  /// Sends [Message] to user.
  /// Throws a [SendMessageFailure] if an exception occurs.
  Future<void> sendMessage(Message message);

  /// Fetch [GetChats] to user.
  /// Throws a [GetChatsFailure] if an exception occurs.
  Future<List<Chat>> getChats(List<String> chatsId);
}
