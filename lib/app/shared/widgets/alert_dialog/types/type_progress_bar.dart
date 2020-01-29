import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TypeProgressBar extends StatefulWidget {
  final String title;
  final Function(Sink<double>) onCreated;
  const TypeProgressBar(
      {Key key, this.title = "Sending", @required this.onCreated})
      : super(key: key);

  @override
  _PopupSelectWidgetState createState() => _PopupSelectWidgetState();
}

class _PopupSelectWidgetState extends State<TypeProgressBar> {
  final BehaviorSubject<double> progress = BehaviorSubject<double>();

  @override
  void initState() {
    widget.onCreated(progress.sink);
    progress.stream.listen((data) {
      // if(data == )
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? "Sending"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: StreamBuilder<double>(
        stream: progress.stream,
        initialData: 0,
        builder: (context, snapshot) {
          print(snapshot.data);
          return LinearProgressIndicator(
            value: snapshot.data,
          );
        }
      ),
    );
  }
}