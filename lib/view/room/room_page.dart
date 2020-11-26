import 'package:cae_app/model/room.dart';
import 'package:cae_app/view/room/room_item.dart';
import 'package:cae_app/view/room/room_view.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> implements RoomView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.colorPrimary),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          RoomItem(),
          RoomItem(),
          RoomItem(),
          RoomItem(),
          RoomItem(),
          RoomItem(),
          RoomItem(),
          RoomItem(),
        ],
      ),
    );
  }

  @override
  void onRoomListError(String message) {
    // TODO: implement onRoomListError
  }

  @override
  void onRoomListSuccess(List<Room> rooms) {
    // TODO: implement onRoomListSuccess
  }
}
