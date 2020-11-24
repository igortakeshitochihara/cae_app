import 'package:cae_app/service/user_service.dart';

class Injector {
  //singleton
  static final Injector _instance = new Injector.internal();
  static String _token = '';

  Injector.internal();

  factory Injector() {
    return _instance;
  }

  void setToken(String token) {
    _token = token;
  }

  UserService get userService {
    return new UserService(_token);
  }
}
