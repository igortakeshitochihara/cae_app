import 'package:cae_app/theme.dart';
import 'package:cae_app/view/home/home_page.dart';
import 'package:cae_app/view/home_teacher/home_teacher_page.dart';
import 'package:cae_app/view/initial/initial_main_page.dart';
import 'package:cae_app/view/initial/initial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_state.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppState().initialize().then((isAuthenticate) {
    Widget _defaultHome = isAuthenticate
        ? (AppState().user.type == 'admin'
            ? new HomePage()
            : new HomeTeacherPage())
        : new InitialMainPage();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(CaeApp(defaultHome: _defaultHome));
    });
  });
}

class CaeApp extends StatelessWidget {
  Widget defaultHome;

  CaeApp({this.defaultHome});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: defaultHome,
      routes: <String, WidgetBuilder>{
        '/initial': (BuildContext context) => new InitialMainPage(),
      },
    );
  }
}
