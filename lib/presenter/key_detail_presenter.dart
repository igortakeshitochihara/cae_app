import 'package:cae_app/base/base_presenter.dart';
import 'package:cae_app/service/injector_service.dart';
import 'package:cae_app/service/key_service.dart';
import 'package:cae_app/service/room_service.dart';
import 'package:cae_app/view/key/key_detail_view.dart';

class KeyDetailPresenter extends BasePresenter {
  KeyDetailView _view;
  KeyService _service;
  RoomService _roomService;

  KeyDetailPresenter(this._view) {
    super.view = view;
    _service = new Injector().keyService;
    _roomService = new Injector().roomService;
  }

  void add(String name, String roomId) {
    _service
        .add('{"name": "$name", "room_id": "$roomId"}')
        .then((data) => _view.onKeyAddSuccess(data.message))
        .catchError((error) =>
            super.onError(error, (message) => _view.onKeyError(message)));
  }

  void update(String name, String hash, String roomId) {
    _service
        .update('{"name": "$name", "room_id": "$roomId", "hash": "$hash"}')
        .then((data) => _view.onKeyUpdateSuccess(data.message))
        .catchError((error) =>
        super.onError(error, (message) => _view.onKeyError(message)));
  }

  void remove(String hash) {
    _service
        .remove(hash)
        .then((data) => _view.onKeyRemoveSuccess(data.message))
        .catchError((error) =>
        super.onError(error, (message) => _view.onKeyError(message)));
  }

  void listRoom() {
    _roomService.list().then((data) => _view.onRoomListSuccess(data)).catchError(
            (error) =>
            super.onError(error, (message) => _view.onRoomListError(message)));
  }
}
