import 'package:desafio_maps/app/modules/home/widgets/place_tile/place_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SugestionsWidget extends StatelessWidget {
  final BehaviorSubject<double> heightBehavior;

  const SugestionsWidget({Key key, @required this.heightBehavior}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double height = (context.findRenderObject() as RenderBox).size.height + 50;
      if(height != heightBehavior.value){
        heightBehavior.sink.add(height);
      };
    });

    return Container(
      child: Column(
        children: <Widget>[
          Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey[200],
          ),
          _recents(),
        ],
      ),
    );
  }

  Widget _recents() => Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "Recents",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListView.separated(
            itemBuilder: (context, position) => PlaceTileWidget(),
            separatorBuilder: (context, position) => Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey[200],
            ),
            itemCount: 4,
            shrinkWrap: true,
          )
        ],
      );
}
