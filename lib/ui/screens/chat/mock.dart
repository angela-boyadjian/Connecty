import 'package:flutter/material.dart';

import 'widgets/received_message.dart';
import 'widgets/sent_message.dart';

class Message {
  final String id;
  final String content;
  final String time;

  const Message(
    this.id,
    this.content,
    this.time,
  );
}

const List<Widget> childList = <Widget>[
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'Hello',
      time: '21:36 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'How are you? What are you doing?',
      time: '21:36 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(-1, 0),
    child: ReceivedMessage(
      content: 'Hello, Angela. I am fine. How are you?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(-1, 0),
    child: ReceivedMessage(
      content: 'Sure, sounds like fun 😂',
      time: '22:57 PM',
      isImage: true,
      imageAddress: 'assets/images/fun.jpg',
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
  Align(
    alignment: Alignment(1, 0),
    child: SentMessage(
      content: 'I am good. Wanna go to the movies this weekend ?',
      time: '22:40 PM',
      isImage: false,
    ),
  ),
];
