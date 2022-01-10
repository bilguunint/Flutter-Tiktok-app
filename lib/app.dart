import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok/style/theme.dart' as style;

import 'main_screen/main_screen.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Nunito',
              ),
          primaryTextTheme: ThemeData.dark().textTheme.apply(
                fontFamily: 'Nunito',
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: style.Colors.scaffoldDarkBack,
            titleTextStyle:
                const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
                statusBarColor: Colors.white),
          ),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.white),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          )),
          scaffoldBackgroundColor: style.Colors.scaffoldDarkBack,
          primaryColorBrightness: Brightness.dark,
          splashColor: Colors.black.withOpacity(0.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.black,
              selectedItemColor: style.Colors.mainColor,
              selectedIconTheme: IconThemeData(color: style.Colors.mainColor),
              unselectedIconTheme: const IconThemeData(color: Colors.white)),
          primaryColor: Colors.black,
          dividerColor: Colors.white54,
          iconTheme: const IconThemeData(color: Colors.white),
          primaryIconTheme: const IconThemeData(color: Colors.black87)),
      home: MainScreen(),
    );
  }
}
