import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';
import 'package:flutter/material.dart';

class SugestionsWidget extends StatelessWidget {
  final Stream<List<PlaceTileModel>> streamListResults;
  final List<PlaceTileModel> initialData;

  const SugestionsWidget({Key key, @required this.streamListResults, this.initialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PlaceTileModel>>(
      stream: streamListResults,
      initialData: initialData,
      builder: (context, snapshot){
        return (snapshot.hasData && snapshot.data.isNotEmpty) ? list(snapshot.data) : recentsAndFavs;
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
      Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
        alignment: Alignment.centerLeft,
        child: Text(
          "Recents",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      list([
        PlaceTileModel(
          subtitle: "Lindo jardim",
          title: "Jardim Botânico",
        ),
        PlaceTileModel(
          subtitle: "Lindo jardim",
          title: "Jardim Botânico",
        ),
      ], showLastDivider: true,),
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
      list([
        PlaceTileModel(
          subtitle: "Lindo jardim",
          title: "Jardim Botânico",
        ),
      ]),
    ],
  );

  Widget list(List<PlaceTileModel> list, {bool showLastDivider = false}) => ListView.separated(
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.zero,
    itemCount: list.length,
    itemBuilder: (context, position) {
      if(showLastDivider && position == (list.length - 1)){
        return Column(
          children: <Widget>[
            PlaceTileWidget(
                placeTile: list[position]
            ),
            _divider
          ],
        );
      }
      return PlaceTileWidget(
          placeTile: list[position]
      );
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