import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Disposable {
  
  BehaviorSubject<double> heightSearch = BehaviorSubject<double>.seeded(50);
  BehaviorSubject<bool> _expanded = BehaviorSubject<bool>.seeded(false);

  Stream<double> get heightSearchOut => Rx.combineLatest2<double, bool, double>(heightSearch.stream, _expanded.stream, (height, expand) => expand ? height : 50);

  void expand(bool expand){
    _expanded.sink.add(expand);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _expanded.close();
    heightSearch.close();
  }

}
  