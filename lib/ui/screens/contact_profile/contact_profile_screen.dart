import 'package:connecty/ui/widgets/background.dart';
import 'package:connecty/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:users/users_repository.dart';

import 'package:data/data_repository.dart';
import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/ui/widgets/avatar.dart';
import 'package:connecty/ui/widgets/button.dart';
import 'package:connecty/constants/constants.dart';

import 'widgets/level_container.dart';
import 'widgets/status_dialog.dart';

class ContactProfileScreen extends StatefulWidget {
  final User contact;

  ContactProfileScreen({Key key, this.contact}) : super(key: key);

  @override
  _ContactProfileScreenState createState() => _ContactProfileScreenState();
}

class _ContactProfileScreenState extends State<ContactProfileScreen> {
  Widget _buildListIcon(User user) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        if (state is ContactsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ContactsError) {
          print("Error in Contacts");
        }
        return StatusDialog(user: user, contact: widget.contact);
      },
    );
  }

  Widget _buildAppBar(textTheme, user) => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(widget.contact.name,
            style: textTheme.headline5.copyWith(color: Colors.white)),
        actions: [
          _buildListIcon(user),
        ],
      );

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
    final User currentUser = context.select((UserBloc bloc) => bloc.state.user);
    final textTheme = Theme.of(context).textTheme;
    final chats = context.select((ChatListBloc bloc) => bloc.state.chats);

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(textTheme, currentUser),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Avatar(url: widget.contact.photo, size: 70.0),
                ),
                SizedBox(height: 20.0),
                Text(widget.contact.bio,
                    style: textTheme.headline5
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                Button(
                  text: tr('SendMessage'),
                  onPressed: () => Navigator.of(context).pushNamed(chatRoute,
                      arguments: getChat(chats, currentUser)),
                ),
                LevelContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
