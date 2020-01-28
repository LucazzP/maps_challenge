import 'dart:io';

import 'package:desafio_maps/app/shared/widgets/alert_dialog/types/type_confirm.dart';
import 'package:desafio_maps/app/shared/widgets/alert_dialog/types/type_error.dart';
import 'package:desafio_maps/app/shared/widgets/alert_dialog/types/type_pick_photo.dart';
import 'package:flutter/material.dart';

class AlertDialogCustom {
  AlertDialogCustom._();

  static void popupPickPhoto(BuildContext context,
      {Function(File file) onPick}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TypePopupPickPhotoWidget(
        onPick: onPick,
      ),
    );
  }

  static void confirm(BuildContext context,
      {Function onConfirm}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TypeConfirm(
        onConfirm: onConfirm,
      ),
    );
  }

  static void error(BuildContext context,
      {String title, String error}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => TypeErrorAlert(
        error: error,
        title: title,
      ),
    );
  }
  
}