import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:easy_localization/easy_localization.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/ui/widgets/avatar.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/widgets/custom_progress_indicator.dart';

import 'widgets/chat_list_item.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.select((UserBloc bloc) => bloc.state.user);

    AppBar _buildAppBar() => AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(tr('Chats'),
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white)),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Avatar(url: user?.photo),
          ),
        );

    _buildChats() {
      return BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
        switch (state.status) {
          case ChatStatus.Initial:
            return Center(child: CustomProgressIndicator());
          case ChatStatus.Error:
            return Center(child: Text('Failed to fetch chats'));
          case ChatStatus.Success:
            return ListView.builder(
              itemCount: state.chats.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatListItem(
                  hasUnreadMessage: state.chats[index].unread > 0,
                  lastMessage: state.chats[index].lastMsgContent,
                  name: state.chats[index].usernames[0],
                  newMesssageCount: state.chats[index].unread,
                  time: timeago.format(state.chats[index].lastMsgDate),
                );
              },
            );
          default:
            return Center(child: CircularProgressIndicator());
        }
      });
    }

    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: _buildChats(),
            ),
          ),
        ),
      ),
    );
  }
}
