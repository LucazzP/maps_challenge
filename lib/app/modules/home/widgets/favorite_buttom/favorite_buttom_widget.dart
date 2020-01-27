import 'package:desafio_maps/app/modules/home/widgets/favorite_buttom/favorite_buttom_bloc.dart';
import 'package:flutter/material.dart';

class FavoriteButtomWidget extends StatelessWidget {
  final FavoriteButtomBloc bloc = FavoriteButtomBloc();
  final Future Function() onTap;
  final bool initialState;

  FavoriteButtomWidget({Key key, this.onTap, this.initialState = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(initialState != false && bloc.favorited.value != initialState) bloc.favorited.sink.add(initialState);

    return InkWell(
      onTap: () {
        if (onTap != null) {
          bloc.favorited.sink.add(!(bloc.favorited.value ?? false));
          onTap();
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        child: StreamBuilder<bool>(
          stream: bloc.favorited.stream,
          initialData: initialState,
          builder: (context, snapshot) {
            return Icon(
              snapshot.data ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
              size: 20,
            );
          },
        ),
      ),
    );
  }
}
