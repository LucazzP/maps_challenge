import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/home_repository.dart';
import 'package:desafio_maps/app/modules/home/models/comment_model.dart';
import 'package:desafio_maps/app/shared/auth/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class NewCommentDialogBloc extends Disposable {
  final DocumentReference place;
  final HomeRepository _repo = HomeModule.to.get<HomeRepository>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final BehaviorSubject<bool> error = BehaviorSubject<bool>();
  int rating;
  String commentary;

  NewCommentDialogBloc(this.place);

  Future<bool> comment() async {
    if(_validate){
      final CommentModel comment = CommentModel(
        comment: commentary,
        rating: rating,
        author: (await AuthProvider.getCurrentUser).displayName,
      );
      try {
        _repo.postNewComment(comment, place);
        return true;
      } catch (e) {
        error.addError(e);
      }
    }
    return false;
  }

  bool get _validate {
    if(formKey.currentState.validate()){
      if(rating != null && commentary != null){
        if(error?.value ?? false) error.sink.add(false);
        return true;
      } else {
        error.sink.add(true);
      }
    }
    return false;
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {}
}