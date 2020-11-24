import 'package:cae_app/theme.dart';
import 'package:cae_app/view/initial/initial_main_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(CaeApp());

class CaeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: InitialMainPage(),
      routes: <String, WidgetBuilder>{
        '/initial': (BuildContext context) => new InitialMainPage(),
      },
    );
  }
}
