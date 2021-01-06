import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/service/room_service.dart';
import 'package:cae_app/view/room/room_detail_view.dart';

class RoomDetailPresenter extends BasePresenter {
  RoomDetailView _view;
  RoomService _service;

  RoomDetailPresenter(this._view) {
    super.view = view;
    _service = new Injector().roomService;
  }

  void add(String name) {
    _service
        .add('{"name": "$name"}')
        .then((data) => _view.onRoomAddSuccess(data.message))
        .catchError((error) =>
            super.onError(error, (message) => _view.onRoomError(message)));
  }

  void update(String name, String hash) {
    _service
        .update('{"name": "$name", "hash": "$hash"}')
        .then((data) => _view.onRoomUpdateSuccess(data.message))
        .catchError((error) =>
        super.onError(error, (message) => _view.onRoomError(message)));
  }

  void remove(String hash) {
    _service
        .remove(hash)
        .then((data) => _view.onRoomRemoveSuccess(data.message))
        .catchError((error) =>
        super.onError(error, (message) => _view.onRoomError(message)));
  }
}
