import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/comment_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class PlaceDetailsBloc extends Disposable {
  final SpotModel place;

  PlaceDetailsBloc(this.place)
      : photo = BehaviorSubject<String>.seeded(place.photo),
        rating = BehaviorSubject<double>.seeded(place.rating),
        comments = BehaviorSubject<List<CommentModel>>.seeded(place.comments) {
    _repo.streamPlace(place.documentReference).listen(_changeStreamsIfNecessary);
  }

  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();

  UserModel get loggedUser => AppModule.to.get<AppBloc>().loggedUser;
  final BehaviorSubject<bool> expanded = BehaviorSubject<bool>.seeded(false);

  bool isFav(SpotModel place) {
    return loggedUser.favorites
        .map((fav) => fav.documentReference)
        .contains(place.documentReference);
  }

  Future<void> favoritePlace(DocumentReference place) {
    return _repo.favoritePlace(place, loggedUser);
  }

  void expand(bool expand) {
    if (expand != expanded.value) expanded.sink.add(expand);
  }

  final BehaviorSubject<String> photo;
  final BehaviorSubject<double> rating;
  final BehaviorSubject<List<CommentModel>> comments;

  void _changeStreamsIfNecessary(SpotModel place) {
    if(photo.value != place.photo){
      photo.sink.add(place.photo);
    }
    if(rating.value != place.rating){
      rating.sink.add(place.rating);
    }
    if(!listEquals(comments.value, place.comments)){
      comments.sink.add(place.comments);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    expanded.close();
    photo.close();
    rating.close();
    comments.close();
  }
}
