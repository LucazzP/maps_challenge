import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Disposable {
  BehaviorSubject<bool> expanded = BehaviorSubject<bool>();

  void expand(bool expand) {
    if(expand != expanded.value) expanded.sink.add(expand);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    expanded.close();
  }
}
