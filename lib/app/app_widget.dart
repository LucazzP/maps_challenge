import 'dart:async';

import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_picker/google_places_picker.dart';

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
    PluginGooglePlacePicker.initialize(
      androidApiKey: "AIzaSyDx0y4YOpQ4KfYAfTLHt7pmKbNmAklhivk",
      iosApiKey: "AIzaSyCW4K6DLeaS3LdO_18PVPUzTe2LzNxTQDY",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      title: 'Maps Challenge',
      theme: ThemeData(
        primaryColor: ColorsApp.deepBlue,
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
