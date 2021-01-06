import 'package:cae_app/base/base_state.dart';
import 'package:cae_app/base/util.dart';
import 'package:cae_app/component/key_item.dart';
import 'package:cae_app/model/key_model.dart';
import 'package:cae_app/presenter/home_teacher_presenter.dart';
import 'package:cae_app/view/home_teacher/home_teacher_view.dart';
import 'package:cae_app/view/key_teacher/key_detail_teacher_page.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme.dart';

class HomeTeacherPage extends StatefulWidget {
  @override
  _HomeTeacherPageState createState() => _HomeTeacherPageState();
}

class _HomeTeacherPageState extends BaseState<HomeTeacherPage>
    implements HomeTeacherView, KeyItemListener {
  HomeTeacherPresenter _presenter;
  bool _isLoading = true;
  List<KeyModel> _listKeys;

  _HomeTeacherPageState() {
    _presenter = new HomeTeacherPresenter(this);
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

  List<Widget> keysAvailable() {
    var items = <Widget>[];
    _listKeys.asMap().forEach((index, KeyModel keyModel) {
      items.add(
          KeyItem(keyModel: keyModel, typeUser: 'teacher', listener: this));
    });
    return items;
  }

  panelKeysAvailable() {
    return GridView.count(
      crossAxisCount: 2,
      children: keysAvailable(),
    );
  }

  List<Widget> keysReturn() {
    var items = <Widget>[];
    _listKeys.asMap().forEach((index, KeyModel keyModel) {
      if (keyModel.availability == 'unavailable' &&
          keyModel.borrowing.user.hash == AppState().user.hash) {
        items.add(
            KeyItem(keyModel: keyModel, typeUser: 'teacher', listener: this));
      }
    });
    return items;
  }

  panelKeysReturn() {
    return GridView.count(
      crossAxisCount: 2,
      children: keysReturn(),
    );
  }

  void _logout() {
    Navigator.pop(context);
    super.onLogout();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Chaves',
            style: TextStyle(color: AppColors.colorBlack),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: FlatButton(
            onPressed: _logout,
            child: Text(
              'Sair',
              style: TextStyle(color: AppColors.colorRed),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(TabBar(
                  indicatorColor: AppColors.colorPrimary,
                  labelColor: AppColors.colorPrimary,
                  unselectedLabelColor: AppColors.colorDisabled,
                  tabs: [Tab(text: 'TODOS'), Tab(text: 'DEVOLVER')],
                )),
                pinned: true,
              ),
            ];
          },
          body: _isLoading
              ? Util.loading()
              : TabBarView(children: [panelKeysAvailable(), panelKeysReturn()]),
        ),
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
    if (typeUser == 'teacher')
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  KeyDetailTeacherPage(keyModel: keyModel))).then((value) {
        if (value) _onLoadList();
      });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: AppColors.colorWhite,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
