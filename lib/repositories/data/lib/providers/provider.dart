import 'package:data/models/message.dart';

class SendMessageFailure implements Exception {}

abstract class AProvider {
  /// Sends [Message] to user.
  /// Throws a [SendMessageFailure] if an exception occurs.
  Future<void> sendMessage(Message message);
}
