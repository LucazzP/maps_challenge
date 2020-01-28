import 'package:flutter/material.dart';

class ErrorAdvise {
  static SnackBar _snackBar(String error){
    return SnackBar(
      content: Text(error, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    );
  }

  static void showSnackBar(BuildContext context, String error, {ScaffoldState scaffoldState}){
    if(scaffoldState != null){
      scaffoldState.showSnackBar(_snackBar(error));
    } else {
      Scaffold.of(context).showSnackBar(_snackBar(error));
    }
  }

  static void showAlertDialog(BuildContext context, String error){
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Error"),
        content: Text(error),
        actions: <Widget>[
          RaisedButton(
            child: Text("Ok"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}