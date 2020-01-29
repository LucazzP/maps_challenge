import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';
import 'package:desafio_maps/app/shared/auth/auth_provider.dart';
import 'package:desafio_maps/app/shared/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SugestionsWidget extends StatelessWidget {
  final Stream<List<PlaceTileModel>> streamListResults;
  final List<PlaceTileModel> initialData;
  final Function(LatLng) onTap;

  const SugestionsWidget(
      {Key key, @required this.streamListResults, this.initialData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlaceTileModel>>(
      stream: streamListResults,
      initialData: initialData,
      builder: (context, snapshot) {
        return (snapshot.hasData && snapshot.data.isNotEmpty)
            ? list(snapshot.data)
            : recentsAndFavs;
      },
    );
  }

  Widget get recentsAndFavs => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey[200],
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "Recents",
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // list([
          //   PlaceTileModel(
          //     subtitle: "Lindo jardim",
          //     title: "Jardim Botânico",
          //   ),
          //   PlaceTileModel(
          //     subtitle: "Lindo jardim",
          //     title: "Jardim Botânico",
          //   ),
          // ], showLastDivider: true,),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "Favorites",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          StreamBuilder<UserModel>(
            stream: AuthProvider.streamCurrentUser,
            builder: (BuildContext context, snapshot) {
              return snapshot.hasData
                  ? list(snapshot.data.favorites
                      .map((fav) => PlaceTileModel(
                            position: LatLng(fav.lat, fav.lng),
                            title: fav.name,
                            subtitle: fav.description,
                            placeId: fav.documentReference.documentID,
                          ))
                      .toList())
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ],
      );

  Widget list(List<PlaceTileModel> list, {bool showLastDivider = false}) =>
      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: list.length,
        itemBuilder: (context, position) {
          final Widget tile = InkWell(
            onTap: onTap == null ? null : () => onTap(list[position].position),
            child: PlaceTileWidget(
              placeTile: list[position],
            ),
          );
          if (showLastDivider && position == (list.length - 1)) {
            return Column(
              children: <Widget>[
                tile,
                _divider
              ],
            );
          }
          return tile;
        },
        separatorBuilder: (context, position) => _divider,
        shrinkWrap: true,
      );

  Widget get _divider => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Divider(
          height: 2,
          thickness: 2,
          color: Colors.grey[100],
        ),
      );
}
