import 'dart:async';

import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  StreamSubscription streamSubscription;
  bool lastIsLogged = false;

  @override
  void initState() {
    if(streamSubscription != null) streamSubscription.cancel();
    streamSubscription =  AppModule.to.get<AppBloc>().isLogged.listen((isLogged) {
      if (isLogged && !lastIsLogged) {
        Modular.navigatorKey.currentState.pushReplacementNamed('/home');
      } else {
        Modular.navigatorKey.currentState.pushReplacementNamed('/');
      }
      lastIsLogged = isLogged;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Maps Challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
