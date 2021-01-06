import 'package:cae_app/base/util.dart';
import 'package:cae_app/model/room.dart';
import 'package:cae_app/presenter/room_detail_presenter.dart';
import 'package:cae_app/view/room/room_detail_view.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class RoomDetailPage extends StatefulWidget {
  final Room room;

  RoomDetailPage({this.room});

  @override
  _RoomDetailPageState createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage>
    implements RoomDetailView {
  var _name = new TextEditingController();
  var _nameFocus = new FocusNode();
  RoomDetailPresenter _presenter;

  _RoomDetailPageState() {
    _presenter = new RoomDetailPresenter(this);
  }

  @override
  void initState() {
    widget.room != null ? _name.text = widget.room.name : _name.text = '';
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  void _add() {
    if (_name.text.length == 0) {
      Util.alert(context, 'warning', 'Preencha o nome');
      FocusScope.of(context).requestFocus(_nameFocus);
      return;
    }
    Util.showLoading(context);
    _presenter.add(_name.text);
  }

  void _remove() {
    Util.showLoading(context);
    _presenter.remove(widget.room.hash);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          widget.room != null ? widget.room.name : 'Adicionar Sala',
          style: TextStyle(color: AppColors.colorBlack),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context, false),
            icon: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: AppColors.colorPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: <Widget>[
          Container(height: MediaQuery.of(context).size.height * 0.3),
          TextField(
            controller: _name,
            focusNode: _nameFocus,
            decoration: const InputDecoration(labelText: 'Nome'),
            keyboardType: TextInputType.text,
            onSubmitted: (String value) {
              _add();
            },
          ),
          SizedBox(height: 40.0),
          FlatButton(
            onPressed: _add,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: AppColors.colorPrimary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('ENVIAR',
                      style: TextStyle(
                          color: AppColors.colorWhite,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.0),
          widget.room != null
              ? FlatButton(
                  onPressed: _remove,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: AppColors.colorGray,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('EXCLUIR',
                            style: TextStyle(
                                color: AppColors.colorWhite,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              : SizedBox(height: 0),
        ],
      ),
    );
  }

  @override
  void onRoomError(String message) {
    Util.closeLoading(context);
    Util.alert(context, 'error', message);
  }

  @override
  void onRoomAddSuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }

  @override
  void onRoomRemoveSuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }
}
