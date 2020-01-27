import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Disposable {
  BehaviorSubject<bool> loading = BehaviorSubject<bool>.seeded(false);

  Future<void> loginFacebook() async {
    loading.sink.add(true);
    try {
      var facebookLogin = FacebookLogin();
      var facebookLoginResult = await facebookLogin.logIn(['email']);

      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          throw facebookLoginResult.errorMessage;
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("CancelledByUser");
          break;
        case FacebookLoginStatus.loggedIn:
          {
            final AuthCredential credential =
                FacebookAuthProvider.getCredential(
              accessToken: facebookLoginResult.accessToken.token,
            );
            AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
            DocumentReference userRef  = Firestore.instance.collection("users").document(authResult.user.uid);
            userRef.get().then((data) {
              if(!data.exists){
                userRef.setData(UserModel(documentReference: data.reference, favorites: [], registredSpots: []).toJson());
              }
            });
            break;
          }
      }
    } catch (e) {
      loading.sink.add(false);
      rethrow;
    }
    loading.sink.add(false);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    loading.close();
  }
}
