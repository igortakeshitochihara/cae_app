import 'package:cae_app/service/room_service.dart';
import 'package:cae_app/service/user_service.dart';

import 'borrowing_service.dart';
import 'key_service.dart';

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

  RoomService get roomService {
    return new RoomService(_token);
  }

  KeyService get keyService {
    return new KeyService(_token);
  }

  BorrowingService get borrowingService {
    return new BorrowingService(_token);
  }
}
