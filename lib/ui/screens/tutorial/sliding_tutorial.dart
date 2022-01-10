import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

import 'tutorial_page.dart';

class SlidingTutorial extends StatefulWidget {
  const SlidingTutorial({
    @required this.controller,
    @required this.notifier,
    @required this.pageCount,
    Key key,
  }) : super(key: key);

  final ValueNotifier<double> notifier;
  final int pageCount;
  final PageController controller;

  @override
  State<StatefulWidget> createState() => _SlidingTutorial();
}

class _SlidingTutorial extends State<SlidingTutorial> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = widget.controller;

    /// Listen to [PageView] position updates.
    _pageController..addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackgroundColor(
      pageController: _pageController,
      pageCount: widget.pageCount,

      /// You can use your own color list for page background
      colors: const [
        Color(0xFF10477a),
        Color(0xFFB6134A),
        Color(0xFFFC9314),
      ],
      child: Container(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: List<Widget>.generate(
                widget.pageCount,
                (index) => _getPageByIndex(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Create different [SlidingPage] for indexes.
  Widget _getPageByIndex(int index) {
    switch (index % 3) {
      case 0:
        return TutorialPage(index, widget.notifier, tr('tutorial.1.title'),
            tr('tutorial.1.content'), "assets/images/texting.png");
      case 1:
        return TutorialPage(index, widget.notifier, tr('tutorial.2.title'),
            tr('tutorial.2.content'), "assets/images/contacts.png");
      case 2:
        return TutorialPage(index, widget.notifier, tr('tutorial.3.title'),
            tr('tutorial.3.content'), "assets/images/friends.png");
      default:
        throw ArgumentError("Unknown position: $index");
    }
  }

  /// Notify [SlidingPage] about current page changes.
  _onScroll() {
    widget.notifier.value = _pageController.page ?? 0;
  }
}
