import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String bio;
  final List<String> chats;
  final List<User> contacts;
  final List<String> notifTokens;

  const User(
    this.id,
    this.email,
    this.name,
    this.photo,
    this.bio,
    this.chats,
    this.contacts,
    this.notifTokens,
  );

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        photo = data['photo'],
        bio = data['bio'],
        chats = data['chats'] != null ? List<String>.from(data['chats']) : null,
        notifTokens = data['notifTokens'] != null
            ? List<String>.from(data['notifTokens'])
            : null,
        contacts =
            List<User>.from(data['contacts'].map((x) => User.fromData(x)));

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'bio': bio,
      'chats': chats,
      'contacts': contacts,
      'notifTokens': notifTokens,
    };
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      json['id'] as String,
      json['name'] as String,
      json['email'] as String,
      json['photo'] as String,
      json['bio'] as String,
      json['chats'] as List<String>,
      json['contacts'] as List<User>,
      json['notifTokens'] as List<String>,
    );
  }

  static User fromSnapshot(DocumentSnapshot snap) {
    return User(
      snap.id,
      snap.data()['name'],
      snap.data()['email'],
      snap.data()['photo'],
      snap.data()['bio'],
      snap.data()['chats'],
      snap.data()['contacts'],
      snap.data()['notifTokens'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'bio': bio,
      'chats': chats,
      'contacts': contacts,
      'notifTokens': notifTokens,
    };
  }

  List<Object> get props => [
        this.id,
        this.email,
        this.name,
        this.photo,
        this.bio,
        this.chats,
        this.contacts,
        this.notifTokens,
      ];
}
