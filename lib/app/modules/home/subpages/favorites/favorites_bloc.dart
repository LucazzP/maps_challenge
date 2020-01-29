import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesBloc extends Disposable {
  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  
  void removeFavorite(DocumentReference spot, UserModel user){
    _repo.favoritePlace(spot, user);
  }

  @override
  void dispose() {}
}
