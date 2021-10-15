import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:users/users_repository.dart';
import 'package:connecty/logic/cubit/cubit.dart';

class StatusDialog extends StatefulWidget {
  final User contact;
  final User user;

  StatusDialog({Key key, this.contact, this.user}) : super(key: key);

  @override
  _StatusDialogState createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  bool _isInList = false;
  ContactsCubit _contactsCubit;

  @override
  void initState() {
    super.initState();
    _contactsCubit = BlocProvider.of<ContactsCubit>(context);
    _contactsCubit.fetchList(widget.user);
    _isInList = _contactsCubit.isInList(widget.user, widget.contact.id);
  }

  Future<void> _onPressedAddContact() async {
    await _contactsCubit.addContact(widget.user.id, widget.contact);
    _isInList = !_isInList;
  }

  _onPressedRmContact() async {
    await _contactsCubit.removeContact(widget.user.id, widget.contact);
    _isInList = !_isInList;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(_isInList ? FontAwesomeIcons.check : FontAwesomeIcons.plus,
            color: _isInList ? Colors.green : Colors.amber),
        onPressed: () {
          !_isInList ? _onPressedAddContact() : _onPressedRmContact();
        });
  }
}
