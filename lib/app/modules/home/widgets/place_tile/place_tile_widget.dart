import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:flutter/material.dart';

class PlaceTileWidget extends StatelessWidget {
  final PlaceTileModel placeTile;

  const PlaceTileWidget({
    Key key,
    this.placeTile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(placeTile.photoUrl),
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  placeTile.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  placeTile.subtitle,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
