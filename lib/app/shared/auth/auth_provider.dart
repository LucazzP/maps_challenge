import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  static Future<FirebaseUser> get getCurrentUser => FirebaseAuth.instance.currentUser();
  static UserModel get getCurrentUserModel => AppModule.to.get<AppBloc>().loggedUser;
  static Stream<UserModel> get streamCurrentUser => AppModule.to.get<AppBloc>().loggedUserOut;
}