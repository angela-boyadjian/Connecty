import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connecty/logic/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';

import './mock.dart' as mock;
import 'widgets/header.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  const ChatScreen({
    Key key,
    this.username,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  Widget _lastMessageDate() {
    return Align(
      alignment: Alignment(0, 0),
      child: Container(
        margin: const EdgeInsets.only(top: 5.0, bottom: 10.0),
        height: 30.0,
        width: 60.0,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            )),
        child: Center(
          child: Text(
            tr("Today"),
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontSize: 12.0),
          ),
        ),
      ),
    );
  }

  Widget _sendMessageTextField() {
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
                    print(_text.text);
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

  _buildChat() {
    final theme = context.select((PreferencesCubit cubit) => cubit.theme);

    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat-background.jpg"),
            fit: BoxFit.cover,
            colorFilter: !theme
                ? ColorFilter.mode(Colors.grey[850], BlendMode.hardLight)
                : ColorFilter.linearToSrgbGamma(),
          ),
        ),
        child: ListView.builder(
          itemCount: mock.childList.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) return _lastMessageDate();
            if (index == mock.childList.length + 1) {
              return SizedBox(height: 20.0);
            }
            return mock.childList[index - 1];
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Header(widget.username),
                  _buildChat(),
                  Divider(height: 0.0, color: Colors.black26),
                  _sendMessageTextField(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
