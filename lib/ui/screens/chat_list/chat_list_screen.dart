import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/ui/widgets/avatar.dart';

import './mock.dart' as mock;

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
              child: ListView.builder(
                itemCount: mock.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return mock.items[index];
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
