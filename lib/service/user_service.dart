import 'package:cae_app/base/base_http.dart';
import 'package:cae_app/model/auth.dart';

class UserService extends HttpBase {
  UserService(String token) : super(token);

  Future<Auth> login(dynamic model) async {
    return await post('/login', model.toString())
        .then((data) => Auth.fromJson(data));
  }

  Future<Auth> register(dynamic model) async {
    return await post('/register', model.toString())
        .then((data) => Auth.fromJson(data));
  }
}
