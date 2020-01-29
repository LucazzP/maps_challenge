import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/login/login_bloc.dart';
import 'package:desafio_maps/app/modules/login/login_module.dart';

void main() {
  Modular.init(AppModule(true));
  Modular.bindModule(LoginModule());
  LoginBloc bloc;

  setUp(() {
    bloc = LoginModule.to.get<LoginBloc>();
  });

  group('LoginBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<LoginBloc>());
    });
  });
}
