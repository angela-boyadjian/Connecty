import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double width;

  const CustomDivider({Key key, @required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.center,
              colors: [
                const Color(0xFFffffff).withOpacity(0.1),
                const Color(0xFFFFFFFF).withOpacity(0.5),
              ],
              stops: const [
                0.1,
                1,
              ],
            ),
          ),
        ),
      );
}
