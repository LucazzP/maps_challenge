import 'package:desafio_maps/app/modules/home/subpages/maps/maps_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_page.dart';
import 'package:desafio_maps/app/modules/home/widgets/search/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => HomeRepository(
            Dio(),
            apiKeyGoogle: "AIzaSyDxQFpheXdkUN6FfTB1fpobL6PgzqeJMiU",
          ),
        ),
        Bind((i) => MapsBloc()),
        Bind((i) => SearchBloc()),
        Bind((i) => HomeBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
