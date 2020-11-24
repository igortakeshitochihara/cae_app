import 'package:cae_app/model/auth.dart';

abstract class InitialMainView {
  void onLoginSuccess(Auth auth);

  void onRegisterSuccess(Auth auth);

  void onError(String message);
}
