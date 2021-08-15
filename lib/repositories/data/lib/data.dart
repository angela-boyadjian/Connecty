import 'package:data/data_repository.dart';
import 'package:data/providers/firestore_provider.dart';

import 'models/message.dart';

class UsersRepository {
  FirestoreProvider _provider = FirestoreProvider();

  Future<void> sendMessage(Message message) async =>
      await _provider.sendMessage(message);
}
