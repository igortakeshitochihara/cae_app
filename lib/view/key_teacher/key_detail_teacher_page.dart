import 'package:cae_app/app_state.dart';
import 'package:cae_app/base/util.dart';
import 'package:cae_app/model/key_model.dart';
import 'package:cae_app/presenter/key_detail_teacher_presenter.dart';
import 'package:cae_app/view/key_teacher/key_detail_teacher_view.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class KeyDetailTeacherPage extends StatefulWidget {
  final KeyModel keyModel;

  KeyDetailTeacherPage({this.keyModel});

  @override
  _KeyDetailTeacherPageState createState() => _KeyDetailTeacherPageState();
}

class _KeyDetailTeacherPageState extends State<KeyDetailTeacherPage> implements KeyDetailTeacherView {
  KeyDetailTeacherPresenter _presenter;

  _KeyDetailTeacherPageState() {
    _presenter = new KeyDetailTeacherPresenter(this);
  }

  bottomLayout() {
    if (widget.keyModel.availability == 'unavailable' &&
        widget.keyModel.borrowing.user.hash == AppState().user.hash) {
      return FlatButton(
        onPressed: () {
          Util.showLoading(context);
          _presenter.returnKey(widget.keyModel.borrowing.hash);
        },
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
              Text('DEVOLVER',
                  style: TextStyle(
                      color: AppColors.colorWhite,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    } else if (widget.keyModel.availability == 'unavailable' &&
        widget.keyModel.borrowing.user.hash != AppState().user.hash) {
      return Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0),
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: AppColors.colorPrimary.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/icon/user.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Emprestado para: ' + widget.keyModel.borrowing.user.name,
                style: TextStyle(
                    color: AppColors.colorBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      );
    } else if (widget.keyModel.availability == 'available') {
      return FlatButton(
        onPressed: () {
          Util.showLoading(context);
          _presenter.borrowing(widget.keyModel.hash);
        },
        padding: const EdgeInsets.all(0.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
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
              Text('PEGAR',
                  style: TextStyle(
                      color: AppColors.colorWhite,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }
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
          widget.keyModel.name,
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
          Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.2),
          Row(
            children: [
              Flexible(
                child: Card(
                  margin: const EdgeInsets.all(0.0),
                  elevation: 2.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: AppColors.colorYellow.withOpacity(0.5),
                            shape: BoxShape.circle,
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(5),
                            // ),
                          ),
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/icon/key.png'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.keyModel.name,
                          style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Flexible(
                child: Card(
                  margin: const EdgeInsets.all(0.0),
                  elevation: 2.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: AppColors.colorBlue.withOpacity(0.5),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/icon/class_room.png'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.keyModel.room.name,
                          style: TextStyle(
                              color: AppColors.colorBlack,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.0),
          bottomLayout()
        ],
      ),
    );
  }

  @override
  void onBorrowingError(String message) {
    Util.closeLoading(context);
    Util.alert(context, 'error', message);
  }

  @override
  void onBorrowingSuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }

  @override
  void onReturnKeyError(String message) {
    Util.closeLoading(context);
    Util.alert(context, 'error', message);
  }

  @override
  void onReturnKeySuccess(String message) {
    Util.closeLoading(context);
    Navigator.pop(context, true);
    Util.alert(context, 'success', message);
  }
}
