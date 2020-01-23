import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: ColorsApp.blue,
      fontSize: 30,
      fontWeight: FontWeight.w900,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('S', style: textStyle),
              Text('N', style: textStyle),
              Text('O', style: textStyle),
              Text('W', style: textStyle),
            ],
          ),
        ),
        Container(
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('M', style: textStyle.copyWith(fontSize: 40)),
              Text('A', style: textStyle.copyWith(fontSize: 40)),
              Text('N', style: textStyle.copyWith(fontSize: 40)),
            ],
          ),
        ),
        Container(
          width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('L', style: textStyle),
              Text('A', style: textStyle),
              Text('B', style: textStyle),
              Text('S', style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}
