import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:easy_localization/easy_localization.dart';

class Emptiness extends StatelessWidget {
  final String message;

  const Emptiness(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            elevation: 20.0,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      tr('emptiness.title'),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(message,
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
              height: 400.0,
              child: FlareActor(
                "assets/animations/Cosmos.flr",
                animation: "Untitled",
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ))
        ]);
  }
}
