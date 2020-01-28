import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class RatingStarsBloc extends Disposable {
  BehaviorSubject<double> rating = BehaviorSubject<double>();

  void changeRating(double _rating){
    if(rating.value != _rating && _rating != 0){
      rating.sink.add(_rating);
    }
  }

  @override
  void dispose() {
    rating.close();
  }
}