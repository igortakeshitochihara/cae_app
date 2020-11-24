import 'package:cae_app/base/util.dart';
import 'package:cae_app/view/home/home_page.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class LoginPage extends StatefulWidget {
  LoginPageListener listener;

  LoginPage({this.listener});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _email = new TextEditingController();
  var _password = new TextEditingController();
  var _emailFocus = new FocusNode();
  var _passwordFocus = new FocusNode();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _login() {
    if (_email.text.length == 0 || !_email.text.contains('@')) {
      Util.alert(context, 'warning', 'Preencha o email');
      FocusScope.of(context).requestFocus(_emailFocus);
      return;
    }
    if (_password.text.length == 0) {
      Util.alert(context, 'warning', 'Preencha a senha');
      FocusScope.of(context).requestFocus(_passwordFocus);
      return;
    }
    widget.listener.onLogin(_email.text, _password.text);
  }

  void _openHome() {
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        Container(height: MediaQuery.of(context).size.height * 0.3),
        TextField(
          controller: _email,
          focusNode: _emailFocus,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          onSubmitted: (String value) {
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _password,
          focusNode: _passwordFocus,
          decoration: const InputDecoration(labelText: 'Senha'),
          keyboardType: TextInputType.text,
          obscureText: true,
          onSubmitted: (String value) {
            _login();
          },
        ),
        SizedBox(height: 40.0),
        FlatButton(
          onPressed: _login,
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
        FlatButton(
          onPressed: () => widget.listener.onBack(),
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
                Text('VOLTAR',
                    style: TextStyle(
                        color: AppColors.colorWhite,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

abstract class LoginPageListener {
  void onLogin(String email, String password);

  void onBack();
}
