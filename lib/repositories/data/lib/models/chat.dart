import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final List<String> avatars;
  final String lastMsgContent;
  final DateTime lastMsgDate;
  final String lastMsgSenderId;
  final List<String> participantsId;
  final int totalMsgs;
  final String type;
  final int unread;
  final List<String> usernames;

  const Chat(
      this.id,
      this.avatars,
      this.lastMsgContent,
      this.lastMsgDate,
      this.lastMsgSenderId,
      this.participantsId,
      this.totalMsgs,
      this.type,
      this.unread,
      this.usernames);

  Chat.fromData(Map<String, dynamic> data)
      : id = data['id'],
        avatars = data['avatars'],
        lastMsgContent = data['lastMsgContent'],
        lastMsgDate = data['lastMsgDate'],
        lastMsgSenderId = data['lastMsgSenderId'],
        participantsId = data['participantsId'],
        totalMsgs = data['totalMsgs'],
        type = data['type'],
        unread = data['unread'],
        usernames = data['usernames'];

  Map<String, Object> toJson() {
    return {
      'id': id,
      'avatars': avatars,
      'lastMsgContent': lastMsgContent,
      'lastMsgDate': lastMsgDate,
      'lastMsgSenderId': lastMsgSenderId,
      'participantsId': participantsId,
      'totalMsgs': totalMsgs,
      'type': type,
      'unread': unread,
      'usernames': usernames,
    };
  }

  static Chat fromJson(Map<String, Object> json) {
    return Chat(
      json['id'] as String,
      json['avatars'] as List<String>,
      json['lastMsgContent'] as String,
      json['lastMsgDate'] as DateTime,
      json['lastMsgSenderId'] as String,
      json['participantsId'] as List<String>,
      json['totalMsgs'] as int,
      json['type'] as String,
      json['unread'] as int,
      json['usernames'] as List<String>,
    );
  }

  static Chat fromSnapshot(DocumentSnapshot snap) {
    return Chat(
      snap.id,
      snap.data()['avatars'],
      snap.data()['lastMsgContent'],
      snap.data()['lastMsgDate'],
      snap.data()['lastMsgSenderId'],
      snap.data()['participantsId'],
      snap.data()['totalMsgs'],
      snap.data()['type'],
      snap.data()['unread'],
      snap.data()['usernames'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'id': id,
      'avatars': avatars,
      'lastMsgContent': lastMsgContent,
      'lastMsgDate': lastMsgDate,
      'lastMsgSenderId': lastMsgSenderId,
      'participantsId': participantsId,
      'totalMsgs': totalMsgs,
      'type': type,
      'unread': unread,
      'usernames': usernames,
    };
  }

  @override
  List<Object> get props => [
        this.id,
        this.avatars,
        this.lastMsgContent,
        this.lastMsgDate,
        this.lastMsgSenderId,
        this.participantsId,
        this.totalMsgs,
        this.type,
        this.unread,
        this.usernames
      ];
}
