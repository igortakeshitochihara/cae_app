import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/service/key_service.dart';
import 'package:cae_app/view/home_teacher/home_teacher_view.dart';

class HomeTeacherPresenter extends BasePresenter {
  HomeTeacherView _view;
  KeyService _service;

  HomeTeacherPresenter(this._view) {
    super.view = view;
    _service = new Injector().keyService;
  }

  void list() {
    _service.list().then((data) => _view.onKeyListSuccess(data)).catchError(
            (error) =>
            super.onError(error, (message) => _view.onKeyListError(message)));
  }
}