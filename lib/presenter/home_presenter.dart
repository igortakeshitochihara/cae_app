import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/model/key_model.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/service/key_service.dart';
import 'package:cae_app/view/home/home_view.dart';

class HomePresenter extends BasePresenter {
  HomeView _view;
  KeyService _service;

  HomePresenter(this._view) {
    super.view = view;
    _service = new Injector().keyService;
  }

  void list() {
    _service.list().then((data) => _view.onKeyListSuccess(data)).catchError(
            (error) =>
            super.onError(error, (message) => _view.onKeyListError(message)));
  }
}