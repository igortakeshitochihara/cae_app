import 'package:cae_app/base/util.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageListener listener;

  RegisterPage({this.listener});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _name = new TextEditingController();
  var _email = new TextEditingController();
  var _password = new TextEditingController();
  var _confirmPassword = new TextEditingController();
  var _nameFocus = new FocusNode();
  var _emailFocus = new FocusNode();
  var _passwordFocus = new FocusNode();
  var _confirmPasswordFocus = new FocusNode();
  String type = '';

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();

    super.dispose();
  }

  sendUser() {
    if (_name.text.length == 0) {
      Util.alert(context, 'warning', 'Preencha o nome');
      FocusScope.of(context).requestFocus(_nameFocus);
      return;
    }
    if (_email.text.length == 0 || !_email.text.contains('@')) {
      Util.alert(context, 'warning', 'Preencha o email');
      FocusScope.of(context).requestFocus(_emailFocus);
      return;
    }
    if (_password.text.length == 0 || _password.text.length < 6) {
      Util.alert(
          context, 'warning', 'Preencha a senha com 6 ou mais caracteres');
      FocusScope.of(context).requestFocus(_passwordFocus);
      return;
    }
    if (_confirmPassword.text.length == 0 || _confirmPassword.text.length < 6) {
      Util.alert(context, 'warning', 'Preencha o email');
      FocusScope.of(context).requestFocus(_confirmPasswordFocus);
      return;
    }
    if (_password.text != _confirmPassword.text) {
      Util.alert(context, 'warning', 'As senhas estão distintas');
      FocusScope.of(context).requestFocus(_confirmPasswordFocus);
      return;
    }
    widget.listener.onRegister(_name.text, _email.text, _password.text, type);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        Container(height: MediaQuery.of(context).size.height * 0.15),
        TextField(
          controller: _name,
          focusNode: _nameFocus,
          decoration: const InputDecoration(labelText: 'Nome'),
          keyboardType: TextInputType.text,
          onSubmitted: (String value) {
            FocusScope.of(context).requestFocus(_emailFocus);
          },
        ),
        SizedBox(height: 20.0),
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
            FocusScope.of(context).requestFocus(_confirmPasswordFocus);
          },
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _confirmPassword,
          focusNode: _confirmPasswordFocus,
          decoration: const InputDecoration(labelText: 'Confirme a senha'),
          keyboardType: TextInputType.text,
          obscureText: true,
          onSubmitted: (String value) {
          },
        ),
        SizedBox(height: 40.0),
        FlatButton(
          onPressed: sendUser,
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

abstract class RegisterPageListener {
  void onRegister(String name, String email, String password, String type);

  void onBack();
}
