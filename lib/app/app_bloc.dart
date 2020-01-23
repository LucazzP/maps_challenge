import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends Disposable {

  AppBloc(){
    FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      if (event != null) {
        isLogged.sink.add(true);
      } else if(isLogged.value == true) {
        isLogged.sink.add(false);
      }
    });
  }

  BehaviorSubject<bool> isLogged = BehaviorSubject<bool>.seeded(false);

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    isLogged.close();
  }
}
