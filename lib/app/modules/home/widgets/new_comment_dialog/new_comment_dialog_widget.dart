import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_maps/app/modules/home/widgets/new_comment_dialog/new_comment_dialog_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/rating_stars/rating_stars_widget.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:desafio_maps/app/shared/widgets/alert_dialog/alert_dialog.dart';
import 'package:desafio_maps/app/shared/widgets/button_expanded/button_expanded_widget.dart';
import 'package:flutter/material.dart';

class NewCommentDialogWidget extends StatefulWidget {
  final DocumentReference place;
  final NewCommentDialogBloc bloc;

  NewCommentDialogWidget(this.place, {Key key})
      : bloc = NewCommentDialogBloc(place),
        super(key: key);

  @override
  _NewCommentDialogWidgetState createState() => _NewCommentDialogWidgetState();
}

class _NewCommentDialogWidgetState extends State<NewCommentDialogWidget> {
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((a) {
      _streamSubscription = widget.bloc.error.stream.listen((data) => {});
      _streamSubscription.onError(
        (error) => AlertDialogCustom.error(
          context,
          error: error.toString(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        height: MediaQuery.of(context).size.height * .4,
        child: Form(
          key: widget.bloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "New Review",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  StreamBuilder<bool>(
                      stream: widget.bloc.error.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        return snapshot.data
                            ? Text(
                                "Click on the stars!",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Container();
                      }),
                ],
              ),
              RatingStarsWidget.selectable(
                onTap: (rating) => widget.bloc.rating = rating,
              ),
              TextFormField(
                validator: (value) => ((value?.length ?? 0) <= 10)
                    ? "Type a larger comment!"
                    : null,
                cursorColor: ColorsApp.deepBlue,
                onChanged: (value) => widget.bloc.commentary = value,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Comment",
                ),
                maxLines: 4,
              ),
              ButtonExpandedWidget(
                text: "Comment",
                onTap: () async {
                  if (await widget.bloc.comment()) {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
