import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends Equatable {
  final String content;
  final bool isLiked;
  final String mediaUrl;
  final String senderId;
  final String targetId;
  final DateTime time;
  final bool wasSeen;

  const Message(this.content, this.isLiked, this.mediaUrl, this.senderId,
      this.targetId, this.time, this.wasSeen);

  Message.fromData(Map<String, dynamic> data)
      : content = data['content'],
        isLiked = data['isLiked'],
        mediaUrl = data['mediaUrl'],
        senderId = data['senderId'],
        targetId = data['targetId'],
        time = data['time'].toDate(),
        wasSeen = data['wasSeen'];

  static Message fromSnapshot(DocumentSnapshot snap) {
    return Message(
      snap.data()['content'],
      snap.data()['isLiked'],
      snap.data()['mediaUrl'],
      snap.data()['senderId'],
      snap.data()['targetId'],
      snap.data()['time'].toDate(),
      snap.data()['wasSeen'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'content': content,
      'isLiked': isLiked,
      'mediaUrl': mediaUrl,
      'senderId': senderId,
      'targetId': targetId,
      'time': time,
      'wasSeen': wasSeen,
    };
  }

  List<Object> get props => [
        this.content,
        this.isLiked,
        this.mediaUrl,
        this.senderId,
        this.targetId,
        this.time,
        this.wasSeen
      ];
}
