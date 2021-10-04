import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:data/models/chat.dart';
import 'package:data/models/message.dart';
import 'package:data/providers/provider.dart';

class FirestoreProvider extends AProvider {
  final chatsCollection = FirebaseFirestore.instance.collection('chats');
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  @override
  Stream<List<Message>> messages(String chatId) {
    final messageCollection =
          messagesCollection.doc(chatId).collection('message');

    return messageCollection .orderBy('time').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> sendMessage(Message message, String chatId) async {
    try {
      final messageCollection =
          messagesCollection.doc(chatId).collection('message');

      return messageCollection.add(message.toDocument());
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
}
