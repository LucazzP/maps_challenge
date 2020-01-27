import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_widget.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:flutter/material.dart';

class NewCommentDialogWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "New Review",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            RatingStarsWidget.selectable(
              onTap: (rating) => print(rating),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Comment"),
              maxLines: 4,
            ),
            RaisedButton(
              color: ColorsApp.yellow,
              textColor: ColorsApp.deepBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {},
              padding: const EdgeInsets.all(12),
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Comment",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
