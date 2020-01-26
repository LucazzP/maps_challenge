import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/subpages/profile/profile_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(HomeModule());
  ProfileBloc bloc;

  setUp(() {
    bloc = HomeModule.to.get<ProfileBloc>();
  });

  group('ProfileBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<ProfileBloc>());
    });
  });
}
