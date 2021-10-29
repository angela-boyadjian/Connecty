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

import 'widgets/status_dialog.dart';

class ContactProfileScreen extends StatefulWidget {
  final User user;

  ContactProfileScreen({Key key, this.user}) : super(key: key);

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
        return StatusDialog(user: user, contact: widget.user);
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
        title: Text(widget.user.name,
            style: textTheme.headline5.copyWith(color: Colors.white)),
        actions: [
          _buildListIcon(user),
        ],
      );

  Chat getChat() {
    final chats = context.select((ChatListBloc bloc) => bloc.state.chats);

    return chats
        .where((chat) =>
            chat.id ==
            '8DhpZWp7YmciwN7PaHCE3VTnIbI2+L7AjYHWWvAfQnWCOADDf88cy9Gv2')
        .first;
  }

  @override
  Widget build(BuildContext context) {
    final User currentUser = context.select((UserBloc bloc) => bloc.state.user);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(textTheme, currentUser),
      body: ListView(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Avatar(url: widget.user.photo, size: 70.0),
                ),
                SizedBox(height: 20.0),
                Text(widget.user.email ?? '', style: textTheme.headline6),
                SizedBox(height: 20.0),
                Button(
                  text: tr('SendMessage'),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(chatRoute, arguments: getChat()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
