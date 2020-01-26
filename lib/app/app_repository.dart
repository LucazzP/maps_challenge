import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppRepository extends Disposable {
  Future<UserModel> getLoggedUser() async{
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final DocumentSnapshot document = await Firestore.instance.collection("users").document(user.uid).get();
    final UserModel userModel = await UserModel.fromDocument(document);
    return userModel;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
