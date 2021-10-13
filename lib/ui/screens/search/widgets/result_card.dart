import 'package:connecty/ui/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:users/users_repository.dart';
import 'package:connecty/constants/constants.dart';

class ResultCard extends StatelessWidget {
  final User user;

  const ResultCard(this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(contactProfileRoute, arguments: user),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        elevation: 2.0,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Color(0xFF0A85AB)]),
              borderRadius: BorderRadius.circular(32)),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Avatar(url: user?.photo, size: 40.0),
                SizedBox(height: 20.0),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
