import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:data/data_repository.dart';
import 'package:users/users_repository.dart';
import 'package:storage/storage_repository.dart';
import 'package:authentication/authentication_repository.dart';

import 'ui/theme.dart';
import 'logic/bloc/bloc.dart';
import 'logic/cubit/cubit.dart';
import 'ui/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  Paint.enableDithering = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('fr', 'FR')],
        path: 'assets/langs',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  final AuthenticationRepository authenticationRepository =
      AuthenticationRepository<FirebaseProvider>();
  final UsersRepository usersRepository = UsersRepository();
  final StorageRepository storageRepository = StorageRepository();
  final DataRepository dataRepository = DataRepository();

  ThemeData getTheme(BuildContext context, PreferencesState state) {
    if (state is PreferencesLoaded) {
      context.watch<PreferencesCubit>().loadTheme();
    }
    if (state is PreferencesTheme) {
      return state.theme ? lightTheme : darkTheme;
    }
    return darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
        RepositoryProvider.value(
          value: usersRepository,
        ),
        RepositoryProvider.value(
          value: storageRepository,
        ),
        RepositoryProvider.value(
          value: storageRepository,
        ),
        RepositoryProvider.value(
          value: dataRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository: authenticationRepository),
          ),
          BlocProvider(create: (context) => PreferencesCubit()),
          BlocProvider(
            lazy: false,
            create: (context) => UserBloc(
                usersRepository: usersRepository,
                authBloc: BlocProvider.of<AuthenticationBloc>(context)),
          ),
          BlocProvider(
            lazy: false,
            create: (context) =>
                StorageBloc(storageRepository: storageRepository),
          ),
          BlocProvider(
              lazy: false,
              create: (context) =>
                  ChatListBloc(dataRepository: dataRepository)),
          BlocProvider<ContactsCubit>(
              lazy: false, create: (context) => ContactsCubit(usersRepository)),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: BlocBuilder<PreferencesCubit, PreferencesState>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                title: 'Connecty',
                theme: getTheme(context, state),
                onGenerateRoute: _appRouter.onGenerateRoute,
              );
            },
          ),
        ),
      ),
    );
  }
}
