import 'package:connecty/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:users/users_repository.dart';

import 'package:connecty/ui/widgets/avatar.dart';

class ResultCard extends StatelessWidget {
  final User user;

  const ResultCard({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(contactProfileRoute, arguments: user),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GlassmorphicContainer(
          width: 350,
          height: 350,
          borderRadius: 20,
          blur: 20,
          padding: const EdgeInsets.all(40),
          alignment: Alignment.bottomCenter,
          border: 1,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.05),
              ],
              stops: const [
                0.1,
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.5),
              const Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Avatar(url: user?.photo, size: 40.0),
              const SizedBox(height: 20.0),
              AutoSizeText(
                user.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
