import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zema/config/routes/routes.dart';
import 'package:zema/config/themes/dark_theme.dart';
import 'package:zema/config/themes/light_theme.dart';
import 'package:zema/features/game_details/presentation/bloc/details_bloc.dart';
import 'package:zema/features/home/presentation/bloc/home_bloc.dart';
import 'package:zema/injector.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(sl(), sl(), sl()),
            lazy: false,
          ),
          BlocProvider<DetailsBloc>(
            create: (context) => DetailsBloc(sl()),
            lazy: false,
          )
        ],
        child: MaterialApp.router(
          title: 'BLoC Clean Zema',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
        ));
  }
}
