import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends Equatable {
  final String id;
  final String content;
  final String time;

  const Message(
    this.id,
    this.content,
    this.time,
  );

  Message.fromData(Map<String, dynamic> data)
      : id = data['id'],
        content = data['content'],
        time = data['time'];

  Map<String, Object> toJson() {
    return {
      'id': id,
      'content': content,
      'time': time,
    };
  }

  static Message fromJson(Map<String, Object> json) {
    return Message(
      json['id'] as String,
      json['content'] as String,
      json['time'] as String,
    );
  }

  static Message fromSnapshot(DocumentSnapshot snap) {
    return Message(
      snap.id,
      snap.data()!['content'],
      snap.data()!['time'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'content': content,
      'time': time,
    };
  }

  List<Object> get props => [
        this.id,
        this.content,
        this.time,
      ];
}
