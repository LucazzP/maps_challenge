import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tinycolor/tinycolor.dart';

showSelectColor(
    {@required BuildContext context,
    @required Function(Color color) ontap}) async {
  await showDialog(
      context: context,
      builder: (context) => _SelectColorWidget(
            onTap: ontap,
          ));
}

class _SelectColorWidget extends StatefulWidget {
  final Function(Color color) onTap;

  _SelectColorWidget({Key key, this.onTap}) : super(key: key);

  @override
  __SelectColorWidgetState createState() => __SelectColorWidgetState();
}

class __SelectColorWidgetState extends State<_SelectColorWidget> {

  List<double> colors = [
    //0xFFDF423A,
    BitmapDescriptor.hueAzure,
    BitmapDescriptor.hueBlue,
    BitmapDescriptor.hueCyan,
    BitmapDescriptor.hueGreen,
    BitmapDescriptor.hueMagenta,
    BitmapDescriptor.hueOrange,
    BitmapDescriptor.hueRed,
    BitmapDescriptor.hueRose,
    BitmapDescriptor.hueViolet,
    BitmapDescriptor.hueYellow,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose a color"),
      content: Wrap(
        direction: Axis.horizontal,
        children: colors
            .map((item) {
              final Color color = TinyColor.fromHSV(HSVColor.fromAHSV(.5, item, 1, 1)).color;
              return InkWell(
                onTap: () {
                  widget.onTap(color);
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(50.0),
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Material(
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 20.0,
                    ),
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ));
            })
            .toList(),
      ),
    );
  }
}
