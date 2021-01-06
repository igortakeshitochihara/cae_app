import 'package:cae_app/model/room.dart';
import 'package:cae_app/view/room/room_detail_page.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class RoomItem extends StatelessWidget {
  final Room room;

  RoomItem({this.room});

  void _openDetail(BuildContext context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => RoomDetailPage(room: room)));
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => _openDetail(context),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          width: MediaQuery.of(context).size.width,
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
                room.name,
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
    );
  }
}
