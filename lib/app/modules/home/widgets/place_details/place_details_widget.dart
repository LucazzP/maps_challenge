import 'package:cached_network_image/cached_network_image.dart';
import 'package:desafio_maps/app/modules/home/models/spot_model.dart';
import 'package:desafio_maps/app/modules/home/widgets/comment_tile/comment_tile_widget.dart';
import 'package:desafio_maps/app/modules/home/widgets/favorite_buttom/favorite_buttom_widget.dart';
import 'package:desafio_maps/app/modules/home/widgets/new_comment_dialog/new_comment_dialog_widget.dart';
import 'package:desafio_maps/app/modules/home/widgets/place_details/place_details_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_widget.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class PlaceDetailsWidget extends StatefulWidget {
  final SpotModel place;
  final Function onTap;
  final bool expanded;

  const PlaceDetailsWidget(
      {Key key, @required this.place, this.onTap, this.expanded = false})
      : super(key: key);

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (widget.expanded)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.close),
                    ),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                width: double.maxFinite,
                height: widget.expanded
                    ? MediaQuery.of(context).size.height * .9
                    : MediaQuery.of(context).size.height * .35,
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  widget.place.photo),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * .15,
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _header,
                              if (widget.expanded) _body
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget get _header => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.place.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.place.description,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
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
            initialState: bloc.isFav(widget.place),
          ),
        ],
      );

  Widget get _body => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Category",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                Text(widget.place.category),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "About",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                Text(widget.place.about),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Comments",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () => showDialog(
                    context: context,
                    child: NewCommentDialogWidget()
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorsApp.deepBlue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.add_comment,
                      color: ColorsApp.deepBlue,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: widget.place.comments.length,
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CommentTileWidget(
                  comment: widget.place.comments[position],
                ),
              );
            },
            separatorBuilder: (context, position) {
              return Divider(
                height: 2,
                thickness: 2,
                color: Colors.grey[100],
              );
            },
          )
        ],
      );
}
