import 'package:flutter/material.dart';
import 'package:connecty/logic/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data/data_repository.dart';

class ComposeMessage extends StatefulWidget {
  final String senderId;
  final String targetId;
  
  const ComposeMessage({
    Key key, this.senderId, this.targetId,
  }) : super(key: key);

  @override
  _ComposeMessageState createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  TextEditingController _text = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          maxLines: 20,
          controller: _text,
          decoration: InputDecoration(
            suffixIcon: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    Message msg = Message(_text.text, false,
                      "",
                      widget.senderId,
                      widget.targetId,
                      DateTime.now(),
                      false,
                    );
                    context.read<ChatBloc>().add(SendMessage(msg));
                    FocusScope.of(context).requestFocus(FocusNode());
                    _text.clear();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {},
                ),
              ],
            ),
            border: InputBorder.none,
            hintText: "enter your message",
          ),
        ),
      ),
    );
  }
}
