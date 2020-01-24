  import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_bloc.dart';
  import 'package:desafio_maps/app/modules/home/widgets/sugestions/sugestions_bloc.dart';
  import 'package:desafio_maps/app/modules/home/widgets/search/search_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_maps/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [Bind((i) => PlaceTileBloc()),Bind((i) => SugestionsBloc()),Bind((i) => SearchBloc()),
        Bind((i) => HomeBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
