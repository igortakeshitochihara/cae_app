import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/service/borrowing_service.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/view/key_teacher/key_detail_teacher_view.dart';

class KeyDetailTeacherPresenter extends BasePresenter {
  KeyDetailTeacherView _view;
  BorrowingService _service;

  KeyDetailTeacherPresenter(this._view) {
    super.view = view;
    _service = new Injector().borrowingService;
  }

  void borrowing(String hash) {
    _service
        .borrowing(hash)
        .then((data) => _view.onBorrowingSuccess(data.message))
        .catchError((error) =>
            super.onError(error, (message) => _view.onBorrowingError(message)));
  }

  void returnKey(String hash) {
    _service
        .returnKey(hash)
        .then((data) => _view.onReturnKeySuccess(data.message))
        .catchError((error) =>
            super.onError(error, (message) => _view.onReturnKeyError(message)));
  }
}
