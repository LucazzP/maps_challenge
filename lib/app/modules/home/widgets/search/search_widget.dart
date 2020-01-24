import 'package:desafio_maps/app/modules/home/home_module.dart';
import 'package:desafio_maps/app/modules/home/widgets/search/search_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/sugestions/sugestions_widget.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final SearchBloc bloc = HomeModule.to.get<SearchBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: StreamBuilder<double>(
              stream: bloc.heightSearchOut,
              initialData: 50,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  width: double.maxFinite,
                  height: snapshot.data,
                  child: Column(
                    children: <Widget>[
                      _search(onAdd: () {}),
                      Visibility(
                        visible: snapshot.data != 50,
                        child:
                            SugestionsWidget(heightBehavior: bloc.heightSearch),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _search({@required Function onAdd}) => Row(
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
              onTap: () => bloc.expand(true),
              onEditingComplete: () => bloc.expand(false),
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
            onPressed: onAdd,
          )
        ],
      );
}
