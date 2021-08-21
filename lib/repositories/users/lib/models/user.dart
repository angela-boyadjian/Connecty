import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String bio;
  final List<String> chats;

  const User(
    this.id,
    this.email,
    this.name,
    this.photo,
    this.bio,
    this.chats,
  );
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        email = data['email'],
        photo = data['photo'],
        bio = data['bio'],
        chats = List<String>.from(data['chats']);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'bio': bio,
      'chats': chats,
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
    };
  }

  List<Object> get props => [
        this.id,
        this.email,
        this.name,
        this.photo,
        this.bio,
        this.chats,
      ];
}
