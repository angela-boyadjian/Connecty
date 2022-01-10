import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AutoSizeText(
          tr(title),
          maxLines: 2,
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
