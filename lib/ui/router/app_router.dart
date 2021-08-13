import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:authentication/authentication.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/ui/widgets/frame.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/screens/login/login_screen.dart';
import 'package:connecty/ui/screens/splash/splash_screen.dart';
import 'package:connecty/ui/screens/profile/profile_screen.dart';
import 'package:connecty/ui/screens/settings/settings_screen.dart';
import 'package:connecty/ui/screens/register/register_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SplashScreenBloc>(
            create: (_) => SplashScreenBloc(),
            child: SplashScreen(),
          ),
        );
      case loginRoute:
        return PageTransition(
          child: BlocProvider(
            create: (_) => LoginCubit(_.read<AuthenticationRepository>()),
            child: LoginScreen(),
          ),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
        );
      case registerRoute:
        return PageTransition(
          child: BlocProvider(
            create: (_) => RegisterCubit(_.read<AuthenticationRepository>()),
            child: RegisterScreen(),
          ),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TabBloc(),
            child: Frame(),
          ),
        );
      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case settingsRoute:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
      default:
        return null;
    }
  }
}
