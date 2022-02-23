import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:users/users_repository.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/screens/login/widgets/social_button.dart';

import 'widgets/register.dart';
import 'widgets/sign_in.dart';

class LoginScreen extends StatefulWidget {
  final bool isRegister;

  const LoginScreen({Key key, this.isRegister = false}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AnimatedTextKit(animatedTexts: [
          ColorizeAnimatedText(
            "Connecty",
            textStyle: Theme.of(context)
                .textTheme
                .headline2
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
            colors: [
              Colors.white,
              Colors.blue,
              Colors.yellow,
              Colors.red,
              Colors.orange,
            ],
          ),
        ], isRepeatingAnimation: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserBloc, UserState>(listener: (userContext, state) {
          var isTuto = context.read<PreferencesCubit>().tutorial;

          switch (state.status) {
            case UserStatus.Success:
              return Navigator.of(context)
                  .pushNamed(isTuto ? tutoRoute : homeRoute);
            case UserStatus.NoUser:
              final user =
                  BlocProvider.of<AuthenticationBloc>(context).state.user;
              BlocProvider.of<UserBloc>(context).add(
                AddUser(
                  User(user.id, user.email, user.name, user.photo, 'new user',
                      [], [], []),
                ),
              );
              break;
            case UserStatus.Error:
              print('Failed to get user in DB');
              break;
            default:
              break;
          }
        }),
        BlocListener<LoginCubit, LoginState>(
          listener: (loginContext, state) {
            if (state is LoginError) {
              print('Authentication failed');
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.orange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildTitle(),
                    widget.isRegister
                        ? BlocProvider(
                            create: (context) => RegisterCubit(
                              context.read<AuthenticationRepository>(),
                            ),
                            child: const Register(),
                          )
                        : const SignIn(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SocialButton(
                            path: 'assets/images/facebook.png',
                            onTap: () => {}),
                        SocialButton(
                            path: 'assets/images/google.png',
                            onTap: () =>
                                context.read<LoginCubit>().logInWithGoogle()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
