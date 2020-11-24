import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cae_app/component/alert_sheet.dart';
import 'package:cae_app/model/user.dart';

import '../theme.dart';

class Util {
  static showMessage(BuildContext context, String title, String message,
      [Function callback]) {
    var _dialog = new AlertDialog(
      title: new Text(title),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              if (callback != null) callback();
            },
            child:
                new Text('OK', style: TextStyle(color: AppColors.colorPrimary)))
      ],
    );
    showDialog(
        context: context, barrierDismissible: false, builder: (_) => _dialog);
  }

  static showLoading(BuildContext context, [String message = 'Aguarde...']) {
    var _dialog = AlertDialog(
      content: Container(
        height: 95.0,
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.colorPrimary)),
            SizedBox(height: 15.0),
            Text(message,
                style: TextStyle(
                    color: AppColors.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (_) => _dialog, barrierDismissible: false);
  }

  static closeLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static loading() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.colorPrimary)),
      ),
    );
  }

  static alert(BuildContext context, String status, String message) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertSheet(status: status, message: message);
      },
    );
  }

  static setPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static removePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<String> getPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<User> getUser() async {
    var data = json.decode(await Util.getPreference('USER'));
    return User.fromJson(data);
  }

  static String convertTime(DateTime date) {
    final formatter = new DateFormat('hh:mm');
    return formatter.format(date);
  }

  static String convertDate(DateTime date) {
    final formatter = new DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  static String convertDateUSA(DateTime date) {
    final formatter = new DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
