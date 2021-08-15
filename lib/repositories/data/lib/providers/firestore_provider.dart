import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:data/models/message.dart';
import 'package:data/providers/provider.dart';

class FirestoreProvider extends AProvider {
  final messagesCollection = FirebaseFirestore.instance.collection('messages');

  @override
  Future<void> sendMessage(Message message) async {
    print("Send message call");
  }
}
