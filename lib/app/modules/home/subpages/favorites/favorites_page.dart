import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/subpages/favorites/favorites_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';
import 'package:desafio_maps/app/shared/auth/auth_provider.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:desafio_maps/app/shared/widgets/alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesBloc bloc = HomeModule.to.get<FavoritesBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<UserModel>(
        stream: AuthProvider.streamCurrentUser,
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
                        return InkWell(
                          onTap: () => AlertDialogCustom.confirm(
                            context,
                            text: "Do you want to remove from favorites?",
                            onConfirm: () => bloc.removeFavorite(
                              spot.documentReference,
                              snapshot.data,
                            ),
                          ),
                          child: PlaceTileWidget(
                            placeTile: PlaceTileModel(
                              title: spot.name,
                              subtitle: spot.description,
                              photo: spot.photo,
                            ),
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
