import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';
import 'package:desafio_maps/app/shared/auth/auth_provider.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<UserModel>(
        stream: AuthProvider.streamCurrentUser,
        builder: (BuildContext context, snapshot) {
          return snapshot.hasData
              ? snapshot.data.registredSpots.isEmpty
                  ? Center(
                      child: Text(
                        "Oops, infelizmente você não registrou\nnenhum ponto turístico, vá ao mapa e colabore\ncom o app adicionando novos postos turísticos!",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Registred tourist spots",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.registredSpots.length,
                          itemBuilder: (context, index) {
                            SpotModel spot =
                                snapshot.data.registredSpots[index];
                            return PlaceTileWidget(
                              placeTile: PlaceTileModel(
                                title: spot.name,
                                subtitle: spot.description,
                                photo: spot.photo,
                              ),
                            );
                          },
                        )
                      ],
                    )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
