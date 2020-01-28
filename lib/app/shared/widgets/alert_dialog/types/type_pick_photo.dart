import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

showPopupSelect(
    {BuildContext context,
    Function(File model) onPick,}) async {
  await showDialog(
      context: context,
      builder: (context) => TypePopupPickPhotoWidget(
            onPick: onPick,
          ));
}

///Model using for detect file or color from use on background

class TypePopupPickPhotoWidget extends StatefulWidget {
  final Function(File path) onPick;
  final bool hasSelectColor;
  const TypePopupPickPhotoWidget(
      {Key key, this.onPick, this.hasSelectColor = true})
      : super(key: key);

  @override
  _PopupSelectWidgetState createState() => _PopupSelectWidgetState();
}

class _PopupSelectWidgetState extends State<TypePopupPickPhotoWidget> {
  _getCamera() async {
    File file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      widget.onPick(file);
      Navigator.pop(context);
    }
  }

  _getGallery() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      widget.onPick(file);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.camera_alt,
              size: 35.0,
            ),
            title: Text(
              'Take a photo',
              style: Theme.of(context).textTheme.button,
            ),
            onTap: () {
              _getCamera();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.image,
              size: 35.0,
            ),
            title: Text(
              'Choose from galery',
              style: Theme.of(context).textTheme.button,
            ),
            onTap: () {
              _getGallery();
            },
          ),
        ],
      ),
    );
  }
}