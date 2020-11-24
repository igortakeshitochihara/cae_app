import 'dart:convert';

import 'package:cae_app/service/injector_service.dart';


import 'base/util.dart';
import 'model/user.dart';

class AppState {
  static final AppState _instance = new AppState.internal();

  AppState.internal();

  factory AppState() {
    return _instance;
  }

  String token;
  User user;
  bool isAuthenticate = false;

  Future<bool> initialize() async {
    token = await Util.getPreference('TOKEN');
    if (token != null) {
      var data = json.decode(await Util.getPreference('USER'));
      if (data != null) {
        user = User.fromJson(data);
        Injector().setToken(token);
        isAuthenticate = true;
      }
    }
    return isAuthenticate;
  }

  saveUser() {
    Util.setPreference('USER', user.toString());
    Util.setPreference('TOKEN', token);
    new Injector().setToken(token);
    isAuthenticate = true;
  }
}
