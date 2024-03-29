import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:users/models/user.dart';
import 'package:users/providers/provider.dart';

class FirestoreProvider extends AProvider {
  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<User> getUser(String id) async {
    try {
      var userData = await usersCollection.doc(id).get();
      if (userData.exists == true) {
        return User.fromData(userData.data());
      } else {
        return null;
      }
    } on Exception {
      throw GetUserFailure();
    }
  }

  @override
  Future<void> addUser(User user) async {
    try {
      return usersCollection.doc(user.id).set(user.toDocument());
    } on Exception {
      throw AddUserFailure();
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    try {
      return usersCollection.doc(user.id).delete();
    } on Exception {
      throw DeleteUserFailure();
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      return usersCollection.doc(user.id).set(user.toDocument());
    } on Exception {
      throw UpdateUserFailure();
    }
  }

  @override
  Future<List<User>> searchByName(String toSearch, String username) async {
    List<User> users = [];

    var data = await usersCollection
        .where('name', isGreaterThanOrEqualTo: toSearch)
        .get();

    for (var e in data.docs) {
      var user = User.fromData(e.data());
      if (user.name != username) users.add(user);
    }
    return users;
  }

  @override
  Future<void> addContact(String userId, User toAdd) async {
    try {
      return usersCollection.doc(userId).update({
        "contacts": FieldValue.arrayUnion([toAdd.toJson()])
      });
    } on Exception {
      throw AddContactFailure();
    }
  }

  @override
  Future<void> removeContact(String userId, User toRemove) async {
    try {
      return usersCollection.doc(userId).update({
        "contacts": FieldValue.arrayRemove([toRemove.toJson()])
      });
    } on Exception {
      throw RemoveContactFailure();
    }
  }
}
