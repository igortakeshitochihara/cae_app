import 'package:cae_app/base/util.dart';
import 'package:cae_app/model/auth.dart';
import 'package:cae_app/presenter/initial_main_presenter.dart';
import 'package:cae_app/theme.dart';
import 'package:cae_app/view/home/home_page.dart';
import 'package:cae_app/view/home_teacher/home_teacher_page.dart';
import 'package:cae_app/view/initial/initial_main_view.dart';
import 'package:cae_app/view/login/login_page.dart';
import 'package:cae_app/view/register/register_page.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import 'initial_page.dart';

class InitialMainPage extends StatefulWidget {
  @override
  _InitialMainPageState createState() => _InitialMainPageState();
}

class _InitialMainPageState extends State<InitialMainPage>
    implements
        InitialPageListener,
        RegisterPageListener,
        LoginPageListener,
        InitialMainView {
  PageController _pageController;
  int _page = 1;
  InitialMainPresenter _presenter;

  _InitialMainPageState() {
    _presenter = new InitialMainPresenter(this);
  }

  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  void _pageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  void _openHome(String typeUser) {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                typeUser == 'admin' ? HomePage() : HomeTeacherPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: _pageChanged,
        children: <Widget>[
          InitialPage(listener: this),
          LoginPage(listener: this),
          RegisterPage(listener: this),
        ],
      ),
    );
  }

  @override
  void onBack() {
    _navigationTapped(0);
  }

  @override
  void onChangePage(int page) {
    _navigationTapped(page);
  }

  @override
  void onLogin(String email, String password) {
    Util.showLoading(context);
    _presenter.login(email, password);
  }

  @override
  void onRegister(String name, String email, String password, String type) {
    Util.showLoading(context);
    _presenter.register(name, email, password, type);
  }

  @override
  void onError(String message) {
    Util.closeLoading(context);
    Util.alert(context, 'error', message);
  }

  @override
  void onLoginSuccess(Auth auth) {
    Util.closeLoading(context);
    AppState().user = auth.user;
    AppState().token = auth.token;
    AppState().saveUser();
    _openHome(auth.user.type);
  }

  @override
  void onRegisterSuccess(Auth auth) {
    Util.closeLoading(context);
    AppState().user = auth.user;
    AppState().token = auth.token;
    AppState().saveUser();
    _openHome(auth.user.type);
  }
}
