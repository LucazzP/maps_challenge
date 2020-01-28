import 'package:flutter/material.dart';

///Model using for detect file or color from use on background

class TypeErrorAlert extends StatefulWidget {
  final String title;
  final String error;
  const TypeErrorAlert(
      {Key key, this.title = "Error", this.error = "Occoured an error"})
      : super(key: key);

  @override
  _PopupSelectWidgetState createState() => _PopupSelectWidgetState();
}

class _PopupSelectWidgetState extends State<TypeErrorAlert> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title, style: TextStyle(color: Colors.redAccent),),
      content: Text(widget.error),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: (){Navigator.of(context).pop();},
        )
      ],
    );
  }
}