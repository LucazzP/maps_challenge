import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FacebookButtonWidget extends StatelessWidget {
  final Function onPressed;
  final bool isLoading;

  const FacebookButtonWidget({
    Key key,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FlatButton(
        onPressed: this.isLoading ? null : this.onPressed,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: ColorsApp.blue)),
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Container(
          width: double.maxFinite,
          alignment: Alignment.center,
          child: this.isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(ColorsApp.blue),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.facebookSquare,
                      color: ColorsApp.blue,
                    ),
                    Text(
                      'Sign in with facebook',
                      style: TextStyle(
                        color: ColorsApp.blue,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
