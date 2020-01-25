import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_widget.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/login/login_module.dart';
import 'package:desafio_maps/app/shared/guards/login_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/home', module: HomeModule(), guards: [LoginGuard()]),
        Router('/', module: LoginModule(), guards: [LoginGuard()]),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
