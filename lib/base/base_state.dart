import 'package:cae_app/base/util.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

abstract class BaseState<T extends StatefulWidget> extends State implements BaseView {
  BaseState() : super();

  @override
  void onUnauthenticated() {
    onLogout();
    Util.alert(context, 'warning',
        'A sua conta não está autenticado, por favor efetue o login novamente!');
  }

  void onLogout() {
    Util.removePreference('TOKEN');
    Util.removePreference('USER');
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/initial', (Route<dynamic> route) => false);
  }
}
