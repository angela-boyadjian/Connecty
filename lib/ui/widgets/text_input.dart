import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool isObscure;

  const TextInput({Key key, this.text, this.controller, this.isObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: theme.textTheme.subtitle1,
      decoration: InputDecoration(
        labelText: text,
        hintStyle: theme.textTheme.subtitle1,
        labelStyle: theme.textTheme.subtitle1,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: text,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(32.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(color: theme.backgroundColor)),
      ),
    );
  }
}
