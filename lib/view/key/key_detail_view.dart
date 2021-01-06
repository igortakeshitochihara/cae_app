import 'package:cae_app/model/room.dart';

abstract class KeyDetailView {
  void onKeyAddSuccess(String message);

  void onKeyRemoveSuccess(String message);

  void onKeyError(String message);

  void onRoomListSuccess(List<Room> rooms);

  void onRoomListError(String message);
}
