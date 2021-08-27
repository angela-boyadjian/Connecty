import 'package:connecty/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:connecty/logic/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:data/data_repository.dart';
import 'package:users/users_repository.dart';
import 'package:connecty/ui/widgets/avatar.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({
    Key key,
    this.chat,
  }) : super(key: key);

  int getContactIndex(User user) => chat.usernames[0] == user.name ? 1 : 0;

  Widget _buildUnreadBox() {
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      height: 18.0,
      width: 18.0,
      decoration: BoxDecoration(
          color: Color(0xFFFF8C00),
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Center(
          child: Text(
        chat.unread.toString(),
        style: TextStyle(fontSize: 11),
      )),
    );
  }

  Widget _buildChatInfos(BuildContext context, bool isUnread) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          timeago.format(chat.lastMsgDate),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: 12.0,
              fontWeight: isUnread ? FontWeight.bold : FontWeight.normal),
        ),
        isUnread ? _buildUnreadBox() : SizedBox()
      ],
    );
  }

  Widget _buildTile(BuildContext context) {
    final user = context.select((UserBloc bloc) => bloc.state.user);
    final int contactIndex = getContactIndex(user);
    final bool isUnread = chat.unread > 0;

    return ListTile(
      title: Text(
        chat.usernames[contactIndex],
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 16.0,
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal),
      ),
      subtitle: Text(
        chat.lastMsgSenderId == user.id
            ? tr('You') + ': ' + chat.lastMsgContent
            : chat.lastMsgContent,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 12.0,
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal),
      ),
      leading: Avatar(url: chat.avatars[contactIndex]),
      trailing: _buildChatInfos(context, isUnread),
      onTap: () => Navigator.of(context).pushNamed(chatRoute, arguments: chat),
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
