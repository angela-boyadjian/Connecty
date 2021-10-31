import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
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
            onTap: () => print('message'),
          ),
          IconSlideAction(
            caption: tr('Edit'),
            color: Colors.indigo,
            iconWidget: Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Icon(FontAwesomeIcons.pen, color: Colors.white)),
            onTap: () => {
              Navigator.of(context)
                  .pushNamed(contactProfileRoute, arguments: widget.contact)
            },
          ),
          IconSlideAction(
            iconWidget: Padding(
                padding: EdgeInsets.only(bottom: 5.0),
                child: Icon(FontAwesomeIcons.star, color: Colors.white)),
            caption: tr('Favorite'),
            color: Colors.deepOrange,
            onTap: () => print('favorite'),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: tr('Delete'),
              color: Colors.red,
              iconWidget: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Icon(FontAwesomeIcons.trash, color: Colors.white)),
              onTap: () {
                print('delete');
              }),
        ],
      ),
    );
  }
}
