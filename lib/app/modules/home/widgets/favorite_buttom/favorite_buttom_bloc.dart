import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteButtomBloc extends Disposable {
  BehaviorSubject<bool> favorited = BehaviorSubject<bool>();

  @override
  void dispose() { 
    favorited.close();
  }
}