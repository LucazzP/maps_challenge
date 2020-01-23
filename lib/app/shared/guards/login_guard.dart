import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginGuard extends RouteGuard{
  @override
  bool canActivate(String url) {
    bool logged = AppModule.to.get<AppBloc>().isLogged.value ?? false;

    switch(url){
      case "/login":
        return !logged;
        break;
      default:
        return logged;
        break;
    }
  }
}