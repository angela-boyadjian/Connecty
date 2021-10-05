import 'package:data/data_repository.dart';
import 'package:data/providers/firestore_provider.dart';

import 'models/message.dart';

class DataRepository {
  FirestoreProvider _provider = FirestoreProvider();

  Future<void> sendMessage(Message message, String chatId) async =>
      await _provider.sendMessage(message, chatId);

  Future<List<Chat>> getChats(List<String> chatsId) async =>
      await _provider.getChats(chatsId);

  Future<Chat> readMessage(String chatId) async =>
      await _provider.readMessage(chatId);

  Stream<List<Message>> messages(String chatId) =>
      _provider.messages(chatId);

  Stream<List<Chat>> chats() =>
      _provider.chats();
}
