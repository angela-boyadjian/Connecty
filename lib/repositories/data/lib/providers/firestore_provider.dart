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
    print("Send message call");
  }
}
