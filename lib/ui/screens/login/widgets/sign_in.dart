import 'package:connecty/logic/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:connecty/ui/widgets/button.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/widgets/text_input.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget horizontalLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 1.0,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 45.0),
        TextInput(
          controller: emailController,
          text: tr('Email'),
        ),
        const SizedBox(height: 25.0),
        TextInput(
          controller: passwordController,
          isObscure: true,
          text: tr('Password'),
        ),
        const SizedBox(height: 35.0),
        Button(
            text: tr('Login'),
            onPressed: () => context.read<LoginCubit>().logInWithCredentials(
                emailController.text, passwordController.text)),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              horizontalLine(),
              Text(tr('OR'), style: textTheme.subtitle1.copyWith(fontSize: 14)),
              horizontalLine()
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        Button(
            text: tr('Register'),
            onPressed: () =>
                Navigator.of(context).pushNamed(loginRoute, arguments: true)),
        const SizedBox(height: 60.0),
      ],
    );
  }
}
