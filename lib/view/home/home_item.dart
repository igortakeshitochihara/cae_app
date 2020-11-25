import 'package:flutter/material.dart';

import '../../theme.dart';

class HomeItem extends StatelessWidget {
  Widget getAvailabilityLayout(String availability) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(
        color: availability == 'available'
            ? AppColors.colorPrimary
            : AppColors.colorGray,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(availability == 'available' ? 'Disponível' : 'Indisponível',
              style: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
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
                'Chave 1 - Sala 1',
                style: TextStyle(
                    color: AppColors.colorBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 10.0),
              getAvailabilityLayout('available')
            ],
          ),
        ),
      ),
    );
  }
}
