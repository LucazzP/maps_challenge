import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/app_repository.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends Disposable {
  AppRepository _repo = AppModule.to.get<AppRepository>();

  AppBloc(){
    FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      if (event != null) {
        isLogged.sink.add(true);
      } else if(isLogged.value == true) {
        isLogged.sink.add(false);
      }
    });
    isLogged.stream.listen((logged) async {
      if(logged){
        _loggedUser.sink.add(await _repo.getLoggedUser());
      } else {
        _loggedUser.sink.add(null);
      }
    });
  }

  BehaviorSubject<bool> isLogged = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<UserModel> _loggedUser = BehaviorSubject<UserModel>();
  Stream<UserModel> get loggedUserOut => _loggedUser.stream;
  UserModel get loggedUser => _loggedUser.value;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    isLogged.close();
    _loggedUser.close();
  }
}
