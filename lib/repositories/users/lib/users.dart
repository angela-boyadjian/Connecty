import 'package:users/users_repository.dart';
import 'package:users/providers/firestore_provider.dart';

import 'models/user.dart';

class UsersRepository {
  FirestoreProvider _provider = FirestoreProvider();

  Future<User> getUser(String id) async => await _provider.getUser(id);

  Future<void> addUser(User user) async => await _provider.addUser(user);

  Future<void> deleteUser(User user) async => await _provider.deleteUser(user);

  Future<void> updateUser(User user) async => await _provider.updateUser(user);

  Future<List<User>> searchByName(String toSearch, String username) async =>
      await _provider.searchByName(toSearch, username);

  Future<void> addContact(String userId, User toAdd) async =>
      await _provider.addContact(userId, toAdd);

  Future<void> removeContact(String userId, User toRemove) async =>
      await _provider.removeContact(userId, toRemove);
}
