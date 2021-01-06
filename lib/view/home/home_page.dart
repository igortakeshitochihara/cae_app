import 'package:cae_app/base/base_state.dart';
import 'package:cae_app/base/util.dart';
import 'package:cae_app/model/key_model.dart';
import 'package:cae_app/presenter/home_presenter.dart';
import 'package:cae_app/component/key_item.dart';
import 'package:cae_app/view/home/home_view.dart';
import 'package:cae_app/view/key/key_detail_page.dart';
import 'package:cae_app/view/room/room_page.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> implements HomeView, KeyItemListener {
  HomePresenter _presenter;
  bool _isLoading = true;
  List<KeyModel> _listKeys;

  _HomePageState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    _onLoadList();
    super.initState();
  }

  void _openRoom() {
    Navigator.pop(context);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => RoomPage()));
  }

  void _logout() {
    Navigator.pop(context);
    super.onLogout();
  }

  Drawer _menu() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.colorWhite),
            accountName: Text(
              AppState().user.name,
              style: TextStyle(color: AppColors.colorBlack),
            ),
            accountEmail: Text(
              AppState().user.email,
              style: TextStyle(color: AppColors.colorGray),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.colorPrimary,
              // backgroundImage: AssetImage('assets/img/no_user.png'),
            ),
          ),
          ListTile(
            onTap: _openRoom,
            title: Text('Salas'),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.colorPrimary,
            ),
          ),
          ListTile(
            onTap: _logout,
            title: Text('Sair'),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.colorPrimary,
            ),
          )
        ],
      ),
    );
  }

  void _onAddKey() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => KeyDetailPage(keyModel: null))).then((value) {
      if (value) _onLoadList();
    });
  }

  void _onLoadList() {
    setState(() {
      _isLoading = true;
    });
    _presenter.list();
  }

  List<Widget> keys() {
    var items = <Widget>[];
    _listKeys.asMap().forEach((index, KeyModel keyModel) {
      items.add(KeyItem(keyModel: keyModel, typeUser: 'admin', listener: this));
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chaves',
          style: TextStyle(color: AppColors.colorBlack),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: AppColors.colorPrimary),
      ),
      drawer: _menu(),
      body: _isLoading
          ? Util.loading()
          : GridView.count(
              crossAxisCount: 2,
              children: keys(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: _onAddKey,
        backgroundColor: AppColors.colorYellow,
        tooltip: 'Adicionar sala',
        child: new Icon(Icons.add),
      ),
    );
  }

  @override
  void onKeyListError(String message) {
    setState(() {
      _isLoading = false;
    });
    Util.alert(context, 'error', message);
  }

  @override
  void onKeyListSuccess(List<KeyModel> keys) {
    setState(() {
      _isLoading = false;
      _listKeys = keys;
    });
  }

  @override
  void onClickDetail(KeyModel keyModel, String typeUser) {
    if (typeUser == 'admin')
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  KeyDetailPage(keyModel: keyModel))).then((value) {
        if (value) _onLoadList();
      });
  }
}
