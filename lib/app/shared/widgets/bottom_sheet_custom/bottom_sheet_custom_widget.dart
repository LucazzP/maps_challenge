import 'package:flutter/material.dart';

class BottomSheetCustomWidget extends StatefulWidget {
  final bool expanded;
  final Widget child;
  final Function onTap;

  const BottomSheetCustomWidget(
      {Key key, this.expanded = false, this.onTap, this.child})
      : super(key: key);

  @override
  _BottomSheetCustomWidgetState createState() =>
      _BottomSheetCustomWidgetState();
}

class _BottomSheetCustomWidgetState extends State<BottomSheetCustomWidget>
    with TickerProviderStateMixin {
  final BorderRadiusGeometry borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        animationController: AnimationController(
            duration: Duration(milliseconds: 200), vsync: this),
        onClosing: () => Navigator.of(context).pop(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
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
                        borderRadius: borderRadius,
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
                    topRight: Radius.circular(8),
                  ),
                ),
                width: double.maxFinite,
                height: widget.expanded
                    ? MediaQuery.of(context).size.height * .9
                    : MediaQuery.of(context).size.height * .35,
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: borderRadius,
                      ),
                      child: widget.child),
                ),
              ),
            ],
          );
        });
  }
}
