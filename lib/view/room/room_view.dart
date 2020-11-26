import 'package:cae_app/model/room.dart';

abstract class RoomView {
  void onRoomListSuccess(List<Room> rooms);

  void onRoomListError(String message);
}