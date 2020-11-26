import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/service/room_service.dart';
import 'package:cae_app/view/room/room_view.dart';

class RoomPresenter extends BasePresenter {
  RoomView _view;
  RoomService _service;

  RoomPresenter(this._view) {
    super.view = view;
    _service = new Injector().roomService;
  }

  void list() {
    _service.list().then((data) => _view.onRoomListSuccess(data)).catchError(
        (error) =>
            super.onError(error, (message) => _view.onRoomListError(message)));
  }
}
