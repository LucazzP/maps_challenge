import 'package:flutter/material.dart';

///Model using for detect file or color from use on background

class TypeConfirm extends StatefulWidget {
  final Function onConfirm;
  const TypeConfirm(
      {Key key, this.onConfirm})
      : super(key: key);

  @override
  _PopupSelectWidgetState createState() => _PopupSelectWidgetState();
}

class _PopupSelectWidgetState extends State<TypeConfirm> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Do you want to delete?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () =>
              Navigator.of(context).pop(true),
          child: const Text("No"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            widget.onConfirm();
          },
          child: const Text("Yes")),
      ],
    );
  }
}