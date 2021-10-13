import 'package:connecty/logic/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:connecty/ui/widgets/button.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/widgets/text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          print('Sign Up Failed');
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(homeRoute);
        }
      },
      child: Column(
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
          const SizedBox(height: 25.0),
          TextInput(
            controller: confirmController,
            isObscure: true,
            text: tr('Confirm_password'),
          ),
          const SizedBox(height: 35.0),
          Button(
              text: tr('Register'),
              onPressed: () => Navigator.of(context).pushNamed(homeRoute)),
          const SizedBox(height: 15.0),
          Button(
              text: tr('Cancel'),
              onPressed: () => Navigator.of(context)
                  .pushNamed(loginRoute, arguments: false)),
          const SizedBox(height: 25.0)
        ],
      ),
    );
  }
}
