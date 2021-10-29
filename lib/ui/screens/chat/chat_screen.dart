import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:data/data_repository.dart';
import 'package:users/users_repository.dart';
import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/widgets/custom_progress_indicator.dart';

import 'widgets/compose_message.dart';
import 'widgets/header.dart';
import 'widgets/sent_message.dart';
import 'widgets/received_message.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({
    Key key,
    this.chat,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int getContactIndex(User user) =>
      widget.chat.usernames[0] == user.name ? 1 : 0;

  Widget _buildCorrectMessage(bool isSender, Message message) {
    final f = new DateFormat.MMMMd('en_US').add_Hm();
    String time = f.format(message.time);

    return Align(
      alignment: Alignment(isSender ? 1 : -1, 0),
      child: isSender
          ? SentMessage(
              content: message.content,
              time: time,
              isImage: false,
            )
          : ReceivedMessage(
              content: message.content,
              time: time,
              isImage: false,
            ),
    );
  }

  Widget _buildMessages(User user) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      switch (state.status) {
        case ChatStatus.Initial:
          return Center(child: CustomProgressIndicator());
        case ChatStatus.Error:
          return Center(child: Text('Failed to fetch chats'));
        case ChatStatus.Empty:
          return Center(child: Text("You don't have chats yet."));
        case ChatStatus.Success:
          return ListView.builder(
            itemCount: state.messages.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildCorrectMessage(
                  user.id == state.messages[index].senderId,
                  state.messages[index]);
            },
          );
        default:
          return Center(child: CustomProgressIndicator());
      }
    });
  }

  _buildChat(User user) {
    final theme = context.select((PreferencesCubit cubit) => cubit.theme);

    return Flexible(
      fit: FlexFit.tight,
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/chat-background.jpg"),
              fit: BoxFit.cover,
              colorFilter: !theme
                  ? ColorFilter.mode(Colors.grey[850], BlendMode.hardLight)
                  : ColorFilter.linearToSrgbGamma(),
            ),
          ),
          child: _buildMessages(user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserBloc bloc) => bloc.state.user);
    final int contactIndex = getContactIndex(user);
    if (widget.chat.unread > 0 && widget.chat.lastMsgSenderId != user.id) {
      context.read<ChatListBloc>().add(OpenChat(widget.chat.id));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Header(widget.chat.usernames[contactIndex],
                      widget.chat.avatars[contactIndex]),
                  _buildChat(user),
                  Divider(height: 0.0, color: Colors.black26),
                  ComposeMessage(
                      senderId: user.id,
                      targetId: widget.chat.participantsId[contactIndex]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
