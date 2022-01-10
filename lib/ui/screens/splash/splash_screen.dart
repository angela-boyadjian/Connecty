import 'package:connecty/ui/screens/tutorial/tutorial.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:authentication/authentication_repository.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/ui/widgets/frame.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/screens/login/login_screen.dart';
import 'package:connecty/ui/widgets/custom_progress_indicator.dart';

class SplashScreen extends StatelessWidget {
  Widget _buildLogo() => Center(
        child: Image.asset(
          "assets/images/login_logo.png",
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      );

  Widget getAuth() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.Authenticated:
          var isTuto = context.watch<PreferencesCubit>().tutorial;
          print('TUTO == $isTuto');

          return BlocProvider(
            create: (context) => TabBloc(),
            child: BlocProvider.value(
              value: context.read<ChatListBloc>(),
              child: isTuto ? Tutorial() : Frame(),
            ),
          );
        case AuthenticationStatus.Unauthenticated:
          return BlocProvider(
            create: (context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: LoginScreen(),
          );
        default:
          return _buildLogo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              if (state is Initial) {
                BlocProvider.of<SplashScreenBloc>(context).add(LoadResources());
                return _buildLogo();
              } else if (state is Loading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    SizedBox(height: 30.0),
                    CustomProgressIndicator(),
                  ],
                );
              }
              return getAuth();
            },
          ),
        ),
      ),
    );
  }
}
