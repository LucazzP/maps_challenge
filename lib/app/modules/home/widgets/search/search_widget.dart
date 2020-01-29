import 'package:desafio_maps/app/modules/home/home_bloc.dart';
import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/widgets/new_spot_bottom_sheet/new_spot_bottom_sheet_widget.dart';
import 'package:desafio_maps/app/modules/home/widgets/search/search_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/sugestions/sugestions_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchBloc bloc = HomeModule.to.get<SearchBloc>();
  final LayerLink layerLink = LayerLink();
  final GlobalKey textFieldKey = GlobalKey();
  final TextEditingController textFieldController = TextEditingController();
  OverlayEntry overlayEntry;

  @override
  void initState() {
    bloc.expanded.stream.listen((value) {
      if (value) {
        updateOverlay();
        try {
          Overlay.of(context).insert(overlayEntry);
        } catch (e) {}
      } else {
        try {
          overlayEntry.remove();
        } catch (e) {}
      }
    });
    textFieldController.addListener(
      () => bloc.updateResults(textFieldController.text),
    );
    super.initState();
  }

  @override
  void deactivate() {
    bloc.expand(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            width: double.maxFinite,
            height: 50,
            child: CompositedTransformTarget(
              link: layerLink,
              child: _search(
                context,
                onAdd: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => NewSpotBottomSheetWidget(),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _search(BuildContext context, {@required Function onAdd}) => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              key: textFieldKey,
              controller: textFieldController,
              onTap: () => bloc.expand(true),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
                bloc.expand(false);
              },
              decoration: InputDecoration(
                hintText: "Search here",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            height: 35,
            width: 2,
            color: Colors.grey[200],
          ),
          IconButton(
            enableFeedback: false,
            icon: Icon(Icons.add),
            color: Colors.grey[700],
            onPressed: onAdd != null
                ? () {
                    bloc.expand(false);
                    onAdd();
                  }
                : null,
          )
        ],
      );

  void updateOverlay() {
    overlayEntry = OverlayEntry(builder: (context) {
      final double heightOffset =
          (textFieldKey.currentContext.findRenderObject() as RenderBox)
                  .size
                  .height -
              7.5;
      final double width = MediaQuery.of(context).size.width - 24;
      return Positioned(
        width: width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(-4, heightOffset),
          child: new Container(
            width: width,
            alignment: Alignment.center,
            child: new Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: SugestionsWidget(
                streamListResults: bloc.listResultsOut,
                initialData: bloc.listResults,
                onTap: (latLng) {
                  HomeModule.to
                      .get<HomeBloc>()
                      .mapController
                      .animateCamera(CameraUpdate.newLatLng(latLng));
                  bloc.expand(false);
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
