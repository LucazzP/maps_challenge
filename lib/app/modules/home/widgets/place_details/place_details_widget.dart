import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/favorite_buttom/favorite_buttom_widget.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_details/place_details_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_widget.dart';
import 'package:flutter/material.dart';

class PlaceDetailsWidget extends StatefulWidget {
  final SpotModel place;

  const PlaceDetailsWidget({Key key, @required this.place}) : super(key: key);

  @override
  _PlaceDetailsWidgetState createState() => _PlaceDetailsWidgetState();
}

class _PlaceDetailsWidgetState extends State<PlaceDetailsWidget>
    with TickerProviderStateMixin {

  final PlaceDetailsBloc bloc = PlaceDetailsBloc(); 
  
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: AnimationController(
          duration: Duration(milliseconds: 200), vsync: this),
      onClosing: () => Navigator.of(context).pop(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * .28,
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Card(
            child: Column(
              children: <Widget>[
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * .15,
                  child: CachedNetworkImage(
                      imageUrl: widget.place.photo, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.place.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18,),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.place.description,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12,),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RatingStarsWidget(
                                initialRating: widget.place.rating,
                              )
                            ],
                          ),
                          FavoriteButtomWidget(
                            onTap: () => bloc.favoritePlace(widget.place.documentReference),
                            initialState: bloc.loggedUser.favorites.contains(widget.place),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
