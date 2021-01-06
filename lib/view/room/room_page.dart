import 'package:cae_app/base/util.dart';
import 'package:cae_app/model/room.dart';
import 'package:cae_app/presenter/room_presenter.dart';
import 'package:cae_app/view/room/room_detail_page.dart';
import 'package:cae_app/view/room/room_item.dart';
import 'package:cae_app/view/room/room_view.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> implements RoomView {
  RoomPresenter _presenter;
  bool _isLoading = true;
  List<Room> _listRooms;

  _RoomPageState() {
    _presenter = new RoomPresenter(this);
  }

  @override
  void initState() {
    _onLoadList();
    super.initState();
  }

  void _onLoadList() {
    setState(() {
      _isLoading = true;
    });
    _presenter.list();
  }

  List<Widget> rooms() {
    var items = <Widget>[];
    _listRooms.asMap().forEach((index, Room room) {
      items.add(RoomItem(room: room));
    });
    return items;
  }

  void _onAddRoom() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => RoomDetailPage(room: null))).then((value) {
      if (value) _onLoadList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Salas',
          style: TextStyle(color: AppColors.colorBlack),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: AppColors.colorPrimary),
      ),
      body: _isLoading
          ? Util.loading()
          : GridView.count(crossAxisCount: 2, children: rooms()),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: _onAddRoom,
        backgroundColor: AppColors.colorBlue,
        tooltip: 'Adicionar sala',
        child: new Icon(Icons.add),
      ),
    );
  }

  @override
  void onRoomListError(String message) {
    setState(() {
      _isLoading = false;
    });
    Util.alert(context, 'error', message);
  }

  @override
  void onRoomListSuccess(List<Room> rooms) {
    setState(() {
      _isLoading = false;
      _listRooms = rooms;
    });
  }
}
