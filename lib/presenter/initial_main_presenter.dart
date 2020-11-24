import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/service/user_service.dart';
import 'package:cae_app/view/initial/initial_main_view.dart';

class InitialMainPresenter extends BasePresenter {
  InitialMainView _view;
  UserService _service;

  InitialMainPresenter(this._view) {
    super.view = view;
    _service = new Injector().userService;
  }

  void login(String email, String password) {
    _service
        .login('{"email": "$email", "password": "$password"}')
        .then((data) => _view.onLoginSuccess(data))
        .catchError((error) =>
        super.onError(error, (message) => _view.onError(message)));
  }

  void register(String name, String email, String password, String type) {
    _service
        .register('{"name": "$name", "email": "$email", "password": "$password", "type": "$type"}')
        .then((data) => _view.onRegisterSuccess(data))
        .catchError((error) =>
        super.onError(error, (message) => _view.onError(message)));
  }
}
