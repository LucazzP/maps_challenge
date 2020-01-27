import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class PlaceDetailsBloc extends Disposable {
  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  UserModel get loggedUser => AppModule.to.get<AppBloc>().loggedUser;
  BehaviorSubject<bool> expanded = BehaviorSubject<bool>.seeded(false);

  bool isFav(SpotModel place) {
    return loggedUser.favorites.map((fav) => fav.documentReference).contains(place.documentReference);
  }

  Future<void> favoritePlace(DocumentReference place){
    return _repo.favoritePlace(place, loggedUser);
  }

  void expand(bool expand){
    if (expand != expanded.value) expanded.sink.add(expand);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
