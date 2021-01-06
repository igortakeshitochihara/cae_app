import 'package:cae_app/base/util.dart';
import 'package:cae_app/model/key_model.dart';
import 'package:cae_app/model/room.dart';
import 'package:cae_app/presenter/key_detail_presenter.dart';
import 'package:cae_app/view/key/key_detail_view.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class KeyDetailPage extends StatefulWidget {
  final KeyModel keyModel;

  KeyDetailPage({this.keyModel});

  @override
  _KeyDetailPageState createState() => _KeyDetailPageState();
}

class _KeyDetailPageState extends State<KeyDetailPage>
    implements KeyDetailView {
  var _name = new TextEditingController();
  var _nameFocus = new FocusNode();
  String _roomId = '';
  List<Room> _listRooms;
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List();
  KeyDetailPresenter _presenter;

  _KeyDetailPageState() {
    _presenter = new KeyDetailPresenter(this);
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  void setup() {
    _presenter.listRoom();
    if (widget.keyModel != null) {
      _name.text = widget.keyModel.name;
      _roomId = widget.keyModel.room.hash;
    }
  }

  void _save() {
    if (_name.text.length == 0) {
      Util.alert(context, 'warning', 'Preencha o nome');
      FocusScope.of(context).requestFocus(_nameFocus);
      return;
    }
    if (_roomId.length == 0) {
      Util.alert(context, 'warning', 'Selecione a sala');
      return;
    }
    Util.showLoading(context);
    widget.keyModel == null
        ? _presenter.add(_name.text, _roomId)
        : _presenter.update(_name.text, widget.keyModel.hash, _roomId);
  }

  void _remove() {
    Util.showLoading(context);
    _presenter.remove(widget.keyModel.hash);
  }

  // setup drop down item
  List<DropdownMenuItem<String>> setupDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    items.add(
        new DropdownMenuItem(value: '', child: new Text('Selecione uma sala')));
    for (Room room in _listRooms) {
      items.add(
          new DropdownMenuItem(value: room.hash, child: new Text(room.name)));
    }
    return items;
  }

  // change drop down item
  void changedDropDownItem(String selectedRoom) {
    setState(() {
      _roomId = selectedRoom;
    });
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
          widget.keyModel != null ? widget.keyModel.name : 'Adicionar Sala',
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
          Container(height: MediaQuery.of(context).size.height * 0.2),
          TextField(
            controller: _name,
            focusNode: _nameFocus,
            decoration: const InputDecoration(labelText: 'Nome'),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 20.0),
          InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Sala',
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _roomId,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              ),
            ),
          ),
          SizedBox(height: 40.0),
          FlatButton(
            onPressed: _save,
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
          widget.keyModel != null
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
  void onKeyAddSuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }

  @override
  void onKeyError(String message) {
    Util.closeLoading(context);
    Util.alert(context, 'error', message);
  }

  @override
  void onKeyRemoveSuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }

  @override
  void onRoomListSuccess(List<Room> rooms) {
    setState(() {
      _listRooms = rooms;
      _dropDownMenuItems = setupDropDownMenuItems();
    });
  }

  @override
  void onRoomListError(String message) {
    Util.alert(context, 'error', message);
  }

  @override
  void onKeyUpdateSuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }
}
