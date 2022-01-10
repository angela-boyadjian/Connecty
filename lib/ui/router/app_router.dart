import 'package:connecty/ui/screens/settings/widgets/informations/community_guidelines.dart';
import 'package:connecty/ui/screens/settings/widgets/informations/privacy_policy.dart';
import 'package:connecty/ui/screens/settings/widgets/informations/terms_of_services.dart';
import 'package:flutter/material.dart';
import 'package:data/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:users/users_repository.dart';
import 'package:authentication/authentication.dart';

import 'package:connecty/logic/bloc/bloc.dart';
import 'package:connecty/ui/widgets/frame.dart';
import 'package:connecty/logic/cubit/cubit.dart';
import 'package:connecty/constants/constants.dart';
import 'package:connecty/ui/screens/chat/chat_screen.dart';
import 'package:connecty/ui/screens/login/login_screen.dart';
import 'package:connecty/ui/screens/splash/splash_screen.dart';
import 'package:connecty/ui/screens/profile/profile_screen.dart';
import 'package:connecty/ui/screens/settings/settings_screen.dart';
import 'package:connecty/ui/screens/profile_edit/profile_edit_screen.dart';
import 'package:connecty/ui/screens/contact_profile/contact_profile_screen.dart';

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
        final bool isRegister = settings.arguments as bool;

        return PageTransition(
          child: BlocProvider(
            create: (_) => LoginCubit(_.read<AuthenticationRepository>()),
            child: LoginScreen(isRegister: isRegister),
          ),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => TabBloc(),
            child: BlocProvider.value(
              value: context.read<ChatListBloc>(),
              child: Frame(),
            ),
          ),
        );
      case chatRoute:
        final Chat chat = settings.arguments as Chat;

        return PageTransition(
          child: BlocProvider(
            create: (_) => ChatBloc(
                dataRepository: _.read<DataRepository>(), chatId: chat.id),
            child: ChatScreen(chat: chat),
          ),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 400),
        );
      case contactProfileRoute:
        final User user = settings.arguments as User;

        return PageTransition(
          child: ContactProfileScreen(contact: user),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case profileEditRoute:
        return PageTransition(
          child: BlocProvider(
            create: (_) => ImageCubit(),
            child: ProfileEditScreen(),
          ),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case settingsRoute:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
      case tosRoute:
        return PageTransition(
          child: TermsOfService(),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case communityRoute:
        return PageTransition(
          child: CommunityGuidelines(),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      case privacyRoute:
        return PageTransition(
          child: PrivacyPolicy(),
          type: PageTransitionType.bottomToTop,
          duration: Duration(milliseconds: 400),
        );
      default:
        return null;
    }
  }
}
