import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:data/models/chat.dart';
import 'package:data/models/message.dart';
import 'package:data/providers/provider.dart';

class FirestoreProvider extends AProvider {
  final chatsCollection = FirebaseFirestore.instance.collection('chats');
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  @override
  Future<void> sendMessage(Message message) async {
    print("Send message call");
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
  Future<List<Message>> getMessages(String id) async {
    print('IN GETMESSAGES IN REPO');
    try {
      List<Message> messages = [];
      var snapshot =
          await messagesCollection.doc(id).collection('message').get();
      print('AFTER SNAPSHOT');
      for (int i = 0; i < snapshot.docs.length; ++i) {
        messages.add(Message.fromData(snapshot.docs[i].data()));
      }
      print('AFTER FOR LOOP');
      return messages;
    } on Exception {
      throw new GetMessagesFailure();
    }
  }
}
