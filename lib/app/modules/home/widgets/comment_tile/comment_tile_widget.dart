import 'package:desafio_maps/app/modules/home/models/comment_model.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class CommentTileWidget extends StatelessWidget {
  final CommentModel comment;

  const CommentTileWidget({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(comment.author),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.star,
              color: ColorsApp.deepBlue,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              comment.rating.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorsApp.deepBlue,
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Text("\"" + comment.comment + "\"", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]),),
      ],
    );
  }
}
