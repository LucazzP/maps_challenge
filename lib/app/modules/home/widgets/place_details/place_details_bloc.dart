import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PlaceDetailsBloc extends Disposable {
  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  UserModel get loggedUser => AppModule.to.get<AppBloc>().loggedUser; 

  Future<void> favoritePlace(DocumentReference place){
    return _repo.favoritePlace(place, loggedUser);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}
