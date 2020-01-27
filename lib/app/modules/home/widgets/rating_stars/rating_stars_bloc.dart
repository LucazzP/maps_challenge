import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class RatingStarsBloc extends Disposable {
  BehaviorSubject<double> rating = BehaviorSubject<double>();

  @override
  void dispose() {
    rating.close();
  }
}