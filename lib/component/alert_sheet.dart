import 'package:flutter/material.dart';

import '../theme.dart';

class AlertSheet extends StatelessWidget {
  String status;
  String message;

  AlertSheet({this.status, this.message});

  icon(String status) {
    switch (status) {
      case 'warning':
        return AssetImage('assets/icon/alert/warning.png');
      case 'error':
        return AssetImage('assets/icon/alert/error.png');
      default:
        return AssetImage('assets/icon/alert/success.png');
    }
  }

  colorButton(String status) {
    switch (status) {
      case 'warning':
        return AppColors.colorWarning.withOpacity(0.5);
      case 'error':
        return AppColors.colorError.withOpacity(0.5);
      default:
        return AppColors.colorSuccess.withOpacity(0.5);
    }
  }

  color(String status) {
    switch (status) {
      case 'warning':
        return AppColors.colorWarning;
      case 'error':
        return AppColors.colorError;
      default:
        return AppColors.colorSuccess;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: <Widget>[
      Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Image(image: icon(status), height: 100),
            SizedBox(height: 20.0),
            new Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.0),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: colorButton(status),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: color(status)),
                ),
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: color(status),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ])
    ]);
  }
}
