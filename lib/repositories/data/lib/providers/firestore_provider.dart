import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:data/models/chat.dart';
import 'package:data/models/message.dart';
import 'package:data/providers/provider.dart';

class FirestoreProvider extends AProvider {
  final chatsCollection = FirebaseFirestore.instance.collection('chats');
  final usersCollection = FirebaseFirestore.instance.collection('users');
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  @override
  Stream<List<Message>> messages(String chatId) {
    final messageCollection =
        messagesCollection.doc(chatId).collection('message');

    return messageCollection.orderBy('time').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Message.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<Chat>> chats() {
    return chatsCollection.orderBy('lastMsgDate').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Chat.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> sendMessage(Message message, String chatId) async {
    try {
      final messageCollection =
          messagesCollection.doc(chatId).collection('message');
      DocumentSnapshot snap = await chatsCollection.doc(chatId).get();
      var chat = Chat.fromData(snap.data());
      var newChat = Chat(
        chat.id,
        chat.avatars,
        message.content,
        message.time,
        message.senderId,
        chat.participantsId,
        chat.totalMsgs + 1,
        chat.type,
        chat.unread + 1,
        chat.usernames,
      );
      await chatsCollection.doc(chatId).set(newChat.toDocument());
      return await messageCollection.add(message.toDocument());
    } on Exception {
      throw SendMessageFailure();
    }
  }

  @override
  Future<List<Chat>> getChats(List<String> chatsId) async {
    try {
      List<Chat> chats = [];
      for (int i = 0; i < chatsId?.length; ++i) {
        DocumentSnapshot chat = await chatsCollection.doc(chatsId[i]).get();
        chats.add(Chat.fromData(chat.data()));
      }
      return chats;
    } on Exception {
      throw new GetChatsFailure();
    }
  }

  @override
  Future<Chat> readMessage(String chatId) async {
    try {
      DocumentSnapshot snap = await chatsCollection.doc(chatId).get();
      var chat = Chat.fromData(snap.data());
      var newChat = Chat(
        chat.id,
        chat.avatars,
        chat.lastMsgContent,
        chat.lastMsgDate,
        chat.lastMsgSenderId,
        chat.participantsId,
        chat.totalMsgs,
        chat.type,
        0,
        chat.usernames,
      );
      await chatsCollection.doc(chatId).set(newChat.toDocument());
      return newChat;
    } on Exception {
      throw ReadMessageFailure();
    }
  }

  @override
  Future<void> createChat(
      Chat chat, List<String> userChats, List<String> contactChats) async {
    try {
      await chatsCollection.doc(chat.id).set(chat.toDocument());
      userChats.add(chat.id);
      usersCollection.doc(chat.participantsId[0]).update({"chats": userChats});
      contactChats.add(chat.id);
      usersCollection
          .doc(chat.participantsId[1])
          .update({"chats": contactChats});
    } on Exception {
      throw CreateChatFailure();
    }
  }
}
