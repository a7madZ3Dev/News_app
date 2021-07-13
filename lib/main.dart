import 'dart:io' show Platform;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:desktop_window/desktop_window.dart';

import './shared/cubit/cubit.dart';
import './layout/home_layout.dart';
import './shared/cubit/states.dart';
import './shared/bloc_observer.dart';
import './shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();

  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      /// set minimum width and height on app
      await DesktopWindow.setMinWindowSize((Size(420.0, 420.0)));
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          create: (BuildContext context) => AppCubit()..getAppMode(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit appCubit = AppCubit.get(context);
          return MaterialApp(
            title: 'ToDo App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              textSelectionTheme:
                  TextSelectionThemeData(cursorColor: Colors.deepOrange),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              iconTheme: IconThemeData(color: Colors.black),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.deepOrangeAccent,
                elevation: 20.0,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.black,
              primaryColorDark: Colors.deepOrange,
              textSelectionTheme:
                  TextSelectionThemeData(cursorColor: Colors.deepOrange),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.white,
                ),
                subtitle1: TextStyle(
                  color: Colors.white,
                ),
              ),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                elevation: 0.0,
                centerTitle: true,
                color: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.black,
                  showUnselectedLabels: true,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.deepOrangeAccent,
                  elevation: 20.0),
            ),
            themeMode: appCubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: Home(),
          );
        },
      ),
    );
  }
}
