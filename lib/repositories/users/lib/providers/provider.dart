import 'package:users/models/user.dart';

class GetUserFailure implements Exception {}

class UpdateUserFailure implements Exception {}

class AddUserFailure implements Exception {}

class DeleteUserFailure implements Exception {}

class AddContactFailure implements Exception {}

class RemoveContactFailure implements Exception {}

abstract class AProvider {
  /// Returns the [User] based on the provided id.
  /// Throws a [GetUserFailure] if an exception occurs.
  Future<User> getUser(String id);

  /// Creates a new user with the provided [User].
  /// Throws a [AddUserFailure] if an exception occurs.
  Future<void> addUser(User user);

  /// Delete the provided [User].
  /// Throws a [DeleteUserFailure] if an exception occurs.
  Future<void> deleteUser(User user);

  /// Updates the provided [User].
  /// Throws a [UpdateUserFailure] if an exception occurs.
  Future<void> updateUser(User user);

  /// Returns a List of [User] which matches the search.
  /// Throws an SearchUserFailure if an exception occurs.
  Future<List<User>> searchByName(String toSearch, String username);

  /// Adds a [User] in contacts list.
  /// Throws an AddContactFailure if an exception occurs.
  Future<void> addContact(String userId, User toAdd);

  /// Removes a [User] from contacts list.
  /// Throws an RemoveContactFailure if an exception occurs.
  Future<void> removeContact(String userId, User toRemove);
}
