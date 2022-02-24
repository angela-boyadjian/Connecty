import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/utils/utils.dart';
import 'package:data/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:users/users_repository.dart';
import 'package:connecty/constants/constants.dart';

class CustomSlidable extends StatefulWidget {
  final User contact;
  final dynamic onChanged;
  final dynamic onDelete;
  final Key key;
  final dynamic controller;
  final GlobalKey keyTuto;
  final dynamic handleFabKey;

  CustomSlidable(
      {this.contact,
      this.onChanged,
      this.onDelete,
      this.key,
      this.controller,
      this.keyTuto,
      this.handleFabKey});
  @override
  _CustomSlidableState createState() => _CustomSlidableState();
}

class _CustomSlidableState extends State<CustomSlidable> {
  GlobalKey keyButton = GlobalKey();

  Chat getNewChat(User user, String chatId) {
    Chat newChat = Chat(
      chatId,
      [user.photo, widget.contact.photo],
      '',
      new DateTime.now(),
      '',
      [user.id, widget.contact.id],
      0,
      'FRIEND',
      0,
      [user.name, widget.contact.name],
    );
    context
        .read<ChatListBloc>()
        .add(CreateChat(newChat, user.chats, widget.contact.chats));
    return newChat;
  }

  Chat getChat(List<Chat> chats, User user) {
    String chatId = getChatId(user.id, widget.contact.id);
    if (chats == null) {
      return getNewChat(user, chatId);
    }
    Iterable<Chat> res = chats.where((chat) => chat.id == chatId);
    if (res.isEmpty) {
      return getNewChat(user, chatId);
    }
    return res.first;
  }

  @override
  Widget build(BuildContext context) {
    final chats = context.select((ChatListBloc bloc) => bloc.state.chats);
    final User currentUser = context.select((UserBloc bloc) => bloc.state.user);

    return Padding(
      key: widget.keyTuto,
      padding: const EdgeInsets.only(right: 50.0),
      child: Slidable(
        controller: widget.controller,
        key: Key(widget.contact.id),
        actionPane: SlidableStrechActionPane(),
        actionExtentRatio: 0.25,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(contactProfileRoute, arguments: widget.contact);
          },
          child: Container(
            child: ListTile(
              leading: Stack(children: <Widget>[
                CircleAvatar(
                    backgroundImage: NetworkImage(widget.contact.photo),
                    radius: 25),
              ]),
              title: Text('${widget.contact.name}'),
              subtitle: Text("${widget.contact.email}"),
            ),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            iconWidget: Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Icon(FontAwesomeIcons.comment, color: Colors.white)),
            caption: 'Message',
            color: Colors.blue,
            onTap: () => Navigator.of(context)
                .pushNamed(chatRoute, arguments: getChat(chats, currentUser)),
          ),
          IconSlideAction(
            caption: tr('See'),
            color: Colors.indigo,
            iconWidget: Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Icon(FontAwesomeIcons.pen, color: Colors.white)),
            onTap: () => {
              Navigator.of(context)
                  .pushNamed(contactProfileRoute, arguments: widget.contact)
            },
          ),
        ],
        secondaryActions: <Widget>[],
      ),
    );
  }
}
