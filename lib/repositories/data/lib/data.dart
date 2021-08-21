import 'package:data/data_repository.dart';
import 'package:data/providers/firestore_provider.dart';

import 'models/message.dart';

class DataRepository {
  FirestoreProvider _provider = FirestoreProvider();

  Future<void> sendMessage(Message message) async =>
      await _provider.sendMessage(message);

  Future<List<Chat>> getChats(List<String> chatsId) async =>
      await _provider.getChats(chatsId);
}
