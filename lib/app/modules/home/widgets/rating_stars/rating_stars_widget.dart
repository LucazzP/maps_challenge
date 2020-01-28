import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_bloc.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class RatingStarsWidget extends StatelessWidget {
  final RatingStarsBloc bloc = RatingStarsBloc();
  final double rating;
  final Function(int) onTap;

  RatingStarsWidget({Key key, this.rating})
      : onTap = null,
        super(key: key);
  RatingStarsWidget.selectable({Key key, this.onTap})
      : rating = 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.changeRating(rating);
    return StreamBuilder<double>(
        stream: bloc.rating.stream,
        initialData: rating ?? 0,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _star(snapshot.data, 1),
              _star(snapshot.data, 2),
              _star(snapshot.data, 3),
              _star(snapshot.data, 4),
              _star(snapshot.data, 5),
            ],
          );
        });
  }

  Widget _star(double rating, int position) {
    rating = rating - (position - 1);
    final String text = _textStar(position);
    final IconData icon = rating >= 1
        ? Icons.star
        : rating > 0 ? Icons.star_half : Icons.star_border;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (rating == 1 && onTap != null)
          Text(
            text,
            style: TextStyle(
              color: ColorsApp.deepBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
        IconButton(
          tooltip: text,
          onPressed: onTap == null
              ? null
              : () {
                  onTap(position);
                  bloc.changeRating(position.toDouble());
                },
          icon: Icon(
            icon,
            color: ColorsApp.deepBlue,
          ),
        ),
      ],
    );
  }

  String _textStar(int position) {
    switch (position) {
      case 1:
        return "Horrible";
        break;
      case 2:
        return "Bad";
        break;
      case 3:
        return "Not bad";
        break;
      case 4:
        return "Nice";
        break;
      case 5:
        return "Awesome";
        break;
      default:
        return "Not bad";
    }
  }
}
