import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/screens/tutorial/sliding_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';
import 'package:flutter_svg/svg.dart';

class Tutorial extends StatefulWidget {
  Tutorial({Key key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  final ValueNotifier<double> notifier = ValueNotifier(0);
  final _pageCtrl = PageController();
  int pageCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        children: <Widget>[
          /// [StatefulWidget] with [PageView] and [AnimatedBackgroundColor].
          SlidingTutorial(
            controller: _pageCtrl,
            pageCount: pageCount,
            notifier: notifier,
          ),

          /// Separator.
          Align(
            alignment: Alignment(0, 0.85),
            child: Container(
              width: double.infinity,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                _pageCtrl.previousPage(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.linear,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                textDirection: TextDirection.rtl,
              ),
              onPressed: () {
                if (_pageCtrl.page == 2) {
                  Navigator.of(context).pushNamed(homeRoute);
                } else {
                  _pageCtrl.nextPage(
                    duration: Duration(milliseconds: 600),
                    curve: Curves.linear,
                  );
                }
              },
            ),
          ),

          /// [SlidingIndicator] for [PageView] in [SlidingTutorial].
          Align(
            alignment: Alignment(0, 0.94),
            child: SlidingIndicator(
              indicatorCount: pageCount,
              notifier: notifier,
              activeIndicator: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
              inActiveIndicator:
                  SvgPicture.asset("assets/images/hollow_circle.svg"),
              margin: 8,
              inactiveIndicatorSize: 20,
              activeIndicatorSize: 20,
            ),
          ),
          Align(
            alignment: Alignment(0.8, 0.94),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(homeRoute),
              child: Text(
                'SKIP',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
