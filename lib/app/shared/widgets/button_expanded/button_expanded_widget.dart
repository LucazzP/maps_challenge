import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class ButtonExpandedWidget extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Function onTap;
  final String text;

  const ButtonExpandedWidget({
    Key key,
    this.color = ColorsApp.yellow,
    this.textColor = ColorsApp.deepBlue,
    this.onTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      textColor: textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: onTap,
      padding: const EdgeInsets.all(12),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
