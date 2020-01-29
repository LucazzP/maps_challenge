import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/widgets/new_spot_bottom_sheet/new_spot_bottom_sheet_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';

void main() {
  Modular.init(AppModule(true));
  Modular.bindModule(HomeModule());
  NewSpotBottomSheetBloc bloc;

  setUp(() {
    bloc = HomeModule.to.get<NewSpotBottomSheetBloc>();
  });

  group('NewSpotBottomSheetBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<NewSpotBottomSheetBloc>());
    });
  });
}
