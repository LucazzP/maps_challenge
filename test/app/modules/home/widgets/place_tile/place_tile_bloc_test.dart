import 'package:flutter_modular/flutter_modular_test.dart';    
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HomeModule());
  PlaceTileBloc bloc;
  
  setUp(() {
      bloc = HomeModule.to.get<PlaceTileBloc>();
  });

  group('PlaceTileBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<PlaceTileBloc>());
    });
  });

}
  