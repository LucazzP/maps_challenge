import 'package:desafio_maps/app/app_bloc.dart';
import 'package:desafio_maps/app/app_module.dart';
import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final AppBloc bloc = AppModule.to.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<UserModel>(
        stream: bloc.loggedUserOut,
        builder: (BuildContext context, snapshot) {
          return snapshot.hasData
              ? snapshot.data.favorites.isEmpty
                  ? Center(
                      child: Text(
                        "Oops, infelizmente você não favoritou\nnenhum ponto turístico, vá ao mapa e adicione\nalgum ponto turístico como favorito!",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data.favorites.length,
                      itemBuilder: (context, index) {
                        SpotModel spot = snapshot.data.favorites[index];
                        return PlaceTileWidget(
                          placeTile: PlaceTileModel(
                            title: spot.name,
                            subtitle: spot.description,
                            photo: spot.photo,
                          ),
                        );
                      },
                    )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
