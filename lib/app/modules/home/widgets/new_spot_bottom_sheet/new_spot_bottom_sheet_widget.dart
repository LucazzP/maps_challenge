import 'dart:io';

import 'package:desafio_maps/app/modules/home/widgets/new_spot_bottom_sheet/new_spot_bottom_sheet_bloc.dart';
import 'package:desafio_maps/app/modules/home/widgets/select_color/select_color_widget.dart';
import 'package:desafio_maps/app/shared/extensions.dart';
import 'package:desafio_maps/app/shared/models/colors_app.dart';
import 'package:desafio_maps/app/shared/widgets/alert_dialog/alert_dialog.dart';
import 'package:desafio_maps/app/shared/widgets/bottom_sheet_custom/bottom_sheet_custom_widget.dart';
import 'package:desafio_maps/app/shared/widgets/button_expanded/button_expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NewSpotBottomSheetWidget extends StatefulWidget {
  @override
  _NewSpotBottomSheetWidgetState createState() =>
      _NewSpotBottomSheetWidgetState();
}

class _NewSpotBottomSheetWidgetState extends State<NewSpotBottomSheetWidget> {
  final NewSpotBottomSheetBloc bloc = NewSpotBottomSheetBloc();
  final TextEditingController controllerColor = TextEditingController();
  final TextEditingController controllerLocation = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();

  @override
  void initState() {
    bloc.color.stream.listen((color) => controllerColor.text = color.toHex());
    bloc.location.stream
        .listen((location) => controllerLocation.text = location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetCustomWidget(
      expanded: true,
      child: Form(
        key: bloc.formKey,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _photo,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    _inputText(
                      "Name",
                      onChanged: (value) => bloc.name = value,
                    ),
                    TypeAheadFormField<String>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controllerCategory,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Category"
                        ),
                        onChanged: (value) => bloc.category = value,
                      ),
                      noItemsFoundBuilder: (context) => ListTile(title: Text("The category will be created!", style: TextStyle(color: Colors.green),),),
                      onSuggestionSelected: (sugestion) => controllerCategory.text = sugestion,
                      itemBuilder: (context, sugestion){
                        return ListTile(
                          title: Text(sugestion),
                        );
                      },
                      getImmediateSuggestions: true,
                      suggestionsCallback: bloc.sugestions,
                      validator: (value) => value != null && value.length > 3 ? null : "Cannot be empty",
                    ),
                    _inputText(
                      "Description",
                      onChanged: (value) => bloc.description = value,
                    ),
                    _inputText(
                      "About",
                      onChanged: (value) => bloc.about = value,
                    ),
                    _inputText(
                      "Location",
                      icon: Icon(Icons.location_on),
                      readOnly: true,
                      controller: controllerLocation,
                      onTap: () => bloc.getLocation,
                    ),
                    StreamBuilder<Color>(
                      stream: bloc.color.stream,
                      builder: (context, snapshot) {
                        return _inputText(
                          "Pin Color",
                          readOnly: true,
                          controller: controllerColor,
                          onTap: () => showSelectColor(
                            context: context,
                            ontap: (color) {
                              if (color != null) {
                                bloc.color.sink.add(color);
                              }
                            },
                          ),
                          icon: Container(
                            alignment: Alignment.center,
                            height: 16,
                            width: 16,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              child: Icon(
                                Icons.color_lens,
                                color: snapshot.data,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    StreamBuilder<String>(
                      stream: bloc.error.stream,
                      builder: (BuildContext context, snapshot) {
                        return snapshot.hasData
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  snapshot.data,
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              )
                            : Container();
                      },
                    ),
                    ButtonExpandedWidget(
                      text: "Add Spot",
                      onTap: () async {
                        if (await bloc.addSpot(context)) {
                          Navigator.of(context).popUntil((test) => test.isFirst);
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputText(
    String title, {
    Widget icon,
    Function(String) onChanged,
    bool readOnly = false,
    Function onTap,
    TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        onChanged: onChanged,
        validator: (value) => value.isEmpty ? "Cannot be empty" : null,
        cursorColor: ColorsApp.deepBlue,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title,
          suffixIcon: icon,
        ),
      ),
    );
  }

  Widget get _photo => StreamBuilder<File>(
        stream: bloc.photo.stream,
        builder: (context, snapshot) {
          return InkWell(
            splashColor: Colors.grey[700],
            onTap: () {
              AlertDialogCustom.popupPickPhoto(
                context,
                onPick: (file) => bloc.photo.sink.add(file),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: snapshot.hasData ? null : Colors.grey[400],
                image: snapshot.hasData
                    ? DecorationImage(
                        image: FileImage(snapshot.data),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * .15,
                child: snapshot.hasData
                    ? null
                    : Icon(
                        Icons.photo_camera,
                        color: ColorsApp.deepBlue,
                        size: 40,
                      ),
                alignment: Alignment.center,
              ),
            ),
          );
        },
      );
}
