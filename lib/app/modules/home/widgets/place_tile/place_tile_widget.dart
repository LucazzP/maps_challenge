import 'package:desafio_maps/app/modules/home/models/place_tile_model.dart';
import 'package:flutter/material.dart';

class PlaceTileWidget extends StatelessWidget {
  final PlaceTileModel placeTile;
  final Function onTap;

  const PlaceTileWidget({
    Key key,
    this.placeTile,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.place, color: Colors.blue,),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
