import 'package:flutter/material.dart';

import '../../theme.dart';

class InitialPage extends StatelessWidget {
  InitialPageListener listener;

  InitialPage({this.listener});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      children: <Widget>[
        Container(height: MediaQuery.of(context).size.height * 0.4),
        FlatButton(
          onPressed: () => listener.onChangePage(2),
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
                Text('REGISTRAR',
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
          onPressed: () => listener.onChangePage(1),
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
                Text('LOGIN',
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
      ],
    );
  }
}

abstract class InitialPageListener {
  void onChangePage(int page);
}
