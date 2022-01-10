import 'package:flutter/material.dart';
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
      home: const MainScreen(),
    );
  }
}
