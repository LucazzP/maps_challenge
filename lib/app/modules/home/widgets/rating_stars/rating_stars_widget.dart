import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_bloc.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class RatingStarsWidget extends StatelessWidget {
  final RatingStarsBloc bloc = RatingStarsBloc();
  final double initialRating;

  RatingStarsWidget({Key key, this.initialRating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: bloc.rating.stream,
      initialData: initialRating ?? 0,
      builder: (context, snapshot) {
        return Row(
          children: <Widget>[
            _star(snapshot.data),
            _star(snapshot.data - 1),
            _star(snapshot.data - 2),
            _star(snapshot.data - 3),
            _star(snapshot.data - 4),
          ],
        );
      }
    );
  }
  
  Widget _star(double rating){
    return Icon(rating >= 1 ? Icons.star : rating > 0 ? Icons.star_half : Icons.star_border, color: ColorsApp.deepBlue,);
  }
}
