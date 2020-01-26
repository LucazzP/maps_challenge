import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_maps/app/modules/home/models/place_details_model.dart';
import 'package:flutter/material.dart';

class PlaceDetailsWidget extends StatefulWidget{
  final PlaceDetailsModel place;

  const PlaceDetailsWidget({Key key, this.place}) : super(key: key);

  @override
  _PlaceDetailsWidgetState createState() => _PlaceDetailsWidgetState();
}

class _PlaceDetailsWidgetState extends State<PlaceDetailsWidget>  with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: AnimationController(duration: Duration(milliseconds: 200), vsync: this),
      onClosing: () => Navigator.of(context).pop(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white
          ),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * .3,
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
            ],
          ),
        );
      },
    );
  }
}
