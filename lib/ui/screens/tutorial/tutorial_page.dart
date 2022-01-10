import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class TutorialPage extends StatelessWidget {
  final int page;
  final String title;
  final String content;
  final String image;
  final ValueNotifier<double> notifier;

  TutorialPage(this.page, this.notifier, this.title, this.content, this.image);

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      page: page,
      notifier: notifier,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(page == 2 ? 20.0 : 0),
            child: Image.asset(image),
          ),
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
