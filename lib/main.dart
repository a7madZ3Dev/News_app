import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './shared/cubit/cubit.dart';
import './layout/home_layout.dart';
import './shared/cubit/states.dart';
import './shared/bloc_observer.dart';
import './shared/styles/styles/themes.dart';
import './shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  final sharedPreferences = await SharedPreferences.getInstance();
  Bloc.observer = MyBlocObserver();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      /// set minimum width and height on app
      await DesktopWindow.setMinWindowSize((Size(420.0, 420.0)));
    }
  }

  runApp(MyApp(sharedPref: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPref;
  const MyApp({
    required this.sharedPref,
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider<AppCubit>(
          create: (BuildContext context) =>
              AppCubit()..getAppMode(sharedPref: sharedPref),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit appCubit = AppCubit.get(context);
          return MaterialApp(
            title: 'News App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: appCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: Home(sharedPref: sharedPref),
          );
        },
      ),
    );
  }
}
