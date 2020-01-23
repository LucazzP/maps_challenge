import 'package:desafio_maps/app/modules/login/login_bloc.dart';
import 'package:desafio_maps/app/modules/login/login_module.dart';
import 'package:desafio_maps/app/modules/login/widgets/facebook_button/facebook_button_widget.dart';
import 'package:desafio_maps/app/modules/login/widgets/logo/logo_widget.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc bloc = LoginModule.to.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 22,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.black87)],
          ),
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              LogoWidget(),
              Text(
                'Challenge',
                style: TextStyle(
                  color: ColorsApp.blue,
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(height: 50),
              StreamBuilder<bool>(
                stream: bloc.loading.stream,
                initialData: false,
                builder: (context, loading) {
                  return FacebookButtonWidget(
                    isLoading: loading.data,
                    onPressed: () => bloc.loginFacebook().catchError(
                          (error) => Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error),
                              backgroundColor: Colors.redAccent,
                            ),
                          ),
                        ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
