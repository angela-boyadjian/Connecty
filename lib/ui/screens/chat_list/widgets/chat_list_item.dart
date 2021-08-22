import 'dart:io';

import 'package:connecty/ui/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:connecty/ui/screens/chat/chat_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final File image;
  final String url;
  final String time;
  final bool hasUnreadMessage;
  final int newMesssageCount;
  final bool isYou;

  const ChatListItem({
    Key key,
    this.image,
    this.name,
    this.lastMessage,
    this.time,
    this.hasUnreadMessage,
    this.newMesssageCount,
    this.url,
    this.isYou,
  }) : super(key: key);

  Widget _buildUnreadBox() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      height: 18.0,
      width: 18.0,
      decoration: BoxDecoration(
          color: Color(0xFFFF8C00),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          )),
      child: Center(
          child: Text(
        newMesssageCount.toString(),
        style: TextStyle(fontSize: 11),
      )),
    );
  }

  Widget _buildChatInfos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          time,
          style: TextStyle(fontSize: 12),
        ),
        hasUnreadMessage ? _buildUnreadBox() : SizedBox()
      ],
    );
  }

  Widget _buildTile(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        isYou ? tr('You') + ': ' + lastMessage : lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12),
      ),
      leading: Avatar(
        imageFile: image,
        url: url,
      ),
      trailing: _buildChatInfos(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(username: name),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: _buildTile(context),
              ),
            ],
          ),
          Divider(
            endIndent: 12.0,
            indent: 12.0,
            height: 0,
          ),
        ],
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: FontAwesomeIcons.trash,
          onTap: () {},
        ),
      ],
    );
  }
}
