import 'package:cae_app/base/base_state.dart';
import 'package:cae_app/view/home/home_item.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  void logout() {
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
            onTap: () => Navigator.pop(context),
            title: Text('Salas'),
            trailing: Icon(
              Icons.class_,
              color: AppColors.colorPrimary,
            ),
          ),
          // ListTile(
          //   onTap: openProfile,
          //   title: Text('Perfil'),
          //   trailing: Icon(
          //     Icons.account_circle,
          //     color: AppColors.colorPrimary,
          //   ),
          // ),
          // ListTile(
          //   onTap: openPassword,
          //   title: Text('Alterar Senha'),
          //   trailing: Icon(
          //     Icons.phonelink_lock,
          //     color: AppColors.colorPrimary,
          //   ),
          // ),
          ListTile(
            onTap: logout,
            title: Text('Sair'),
            trailing: Icon(
              Icons.arrow_back,
              color: AppColors.colorPrimary,
            ),
          )
        ],
      ),
    );
  }

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
      drawer: _menu(),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          HomeItem(),
          HomeItem(),
          HomeItem(),
          HomeItem(),
          HomeItem(),
          HomeItem(),
          HomeItem(),
          HomeItem(),
        ],
      ),
    );
  }
}
